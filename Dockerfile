# Builder stage
FROM quay.io/keycloak/keycloak:24.0 as builder
ENV KC_DB=postgres

RUN /opt/keycloak/bin/kc.sh build

# Production stage
FROM quay.io/keycloak/keycloak:24.0

COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY keycloak/themes /opt/keycloak/themes
COPY keycloak/standalone/deployments /opt/keycloak/standalone/deployments
COPY keycloak/realm/realm-export.json /opt/keycloak/data/import/realm-export.json

EXPOSE 7080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized", "--proxy=edge", "--http-enabled=true", "--http-port=7080", "--http-host=0.0.0.0"]