# Use Node.js LTS with pnpm
FROM node:20-alpine AS base

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10.26.1 --activate

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Install dependencies
FROM base AS dependencies
RUN pnpm install --no-frozen-lockfile

# Build stage
FROM base AS build
ARG BUILD_ID=dev
ENV BUILD_ID=$BUILD_ID
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

# Build the Nuxt application
RUN pnpm build

# Production stage
FROM node:20-alpine AS production

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10.26.1 --activate
RUN apk add --no-cache curl

WORKDIR /app

# Copy built application
COPY --from=build /app/.output ./.output
COPY --from=build /app/package.json ./package.json

# Expose port
EXPOSE 3000

# Set environment to production
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000
# Start the application
CMD ["node", ".output/server/index.mjs"]
