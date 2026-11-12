FROM registry.access.redhat.com/ubi9/nodejs-22-minimal:9.9-1793849022 AS builder

WORKDIR /build

COPY package.json tsconfig.json ./
RUN npm install

COPY src ./src
RUN npm run build

FROM registry.access.redhat.com/ubi9/nodejs-22-minimal:9.9-1793849022

WORKDIR /app

COPY --from=builder /build/dist ./dist
COPY --from=builder /build/package.json .
RUN npm install --omit=dev

USER 1001

CMD ["node", "dist/index.js"]
