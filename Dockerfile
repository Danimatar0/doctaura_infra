# Builder stage
FROM quay.io/keycloak/keycloak:24.0 as builder


# Download HTTP Event Listener extension
ADD --chown=keycloak:keycloak https://github.com/aznamier/keycloak-event-listener-http/releases/download/1.1.0/event-listener-http-jar-with-dependencies.jar /opt/keycloak/providers/event-listener-http.jar

# Build Keycloak with the extension
RUN /opt/keycloak/bin/kc.sh build

# Production stage
FROM quay.io/keycloak/keycloak:24.0

# Copy built Keycloak with extension from builder
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Copy custom themes and realm configuration
COPY keycloak/themes /opt/keycloak/themes
COPY keycloak/realm/realm-export.json /opt/keycloak/data/import/realm-export.json

# Expose the port Keycloak will run on
EXPOSE 7080

# Set the entrypoint command
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized", "--proxy=edge", "--http-enabled=true", "--http-port=7080", "--http-host=0.0.0.0"]