FROM registry.redhat.io/ubi9/nodejs-22-minimal:latest AS builder

WORKDIR /build

COPY package.json tsconfig.json ./
RUN npm install

COPY src ./src
RUN npm run build

FROM registry.redhat.io/ubi9/nodejs-22-minimal:latest

WORKDIR /app

COPY --from=builder /build/dist ./dist
COPY --from=builder /build/package.json .
RUN npm install --omit=dev

USER 1001

CMD ["node", "dist/index.js"]
