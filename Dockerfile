FROM registry.access.redhat.com/ubi9/nodejs-22-minimal:9.9-1793849022 AS builder

USER 0

WORKDIR /build

COPY package.json tsconfig.json ./
RUN chown -R 1001:0 /build

USER 1001

RUN npm install

COPY --chown=1001:0 src ./src

RUN npm run build


FROM registry.access.redhat.com/ubi9/nodejs-22-minimal:9.9-1793849022

USER 0

WORKDIR /app

COPY --from=builder --chown=1001:0 /build/dist ./dist
COPY --from=builder --chown=1001:0 /build/package.json .

USER 1001

RUN npm install --omit=dev

CMD ["node", "dist/index.js"]
