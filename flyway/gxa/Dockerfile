FROM flyway/flyway

COPY baseline /flyway/sql
COPY migrations /flyway/sql

ENV FLYWAY_URL="jdbc:postgresql://localhost:5432/db"
ENV FLYWAY_USER=user
ENV FLYWAY_SCHEMAS=user
ENV FLYWAY_PASSWORD=password

CMD ["migrate"]
