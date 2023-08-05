package com.example.rwaprojekat.db;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import org.flywaydb.core.Flyway;

public class MigrationServletContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Flyway flyway = Flyway.configure()
                .dataSource("jdbc:mysql://localhost:3306/rwaprojekat", "root", "root")
                .load();
        flyway.migrate();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
