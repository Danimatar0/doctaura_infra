FROM quay.io/keycloak/keycloak:24.0

# Copy custom themes and realm configuration
# Make sure these paths match your local directory structure
COPY keycloak/themes /opt/keycloak/themes
COPY keycloak/realm/realm-export.json /opt/keycloak/data/import/realm-export.json

# Expose the port Keycloak will run on
EXPOSE 7080

# Set the entrypoint command
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--proxy=edge", "--hostname=keycloak.danmtech.com", "--http-enabled=true", "--http-port=7080"]