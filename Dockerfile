FROM node:lts-alpine as build
WORKDIR /build
RUN npm install homebridge homebridge-adguardhome homebridge-hue homebridge-nest

FROM gcr.io/distroless/nodejs:18-amd64
WORKDIR /home/nonroot
USER nonroot
COPY --from=build --chown=nonroot /build /home/nonroot
CMD [ "./node_modules/homebridge/bin/homebridge", \
  "--no-qrcode", \
  "--strict-plugin-resolution", \
  "--no-timestamp", \
  "--plugin-path", "./node_modules", \
  "--user-storage-path", "./data" \
]
