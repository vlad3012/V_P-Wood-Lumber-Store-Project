package com.example.lumberstore.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.Properties;

@Configuration
@PropertySource("classpath:application.properties")
@EnableTransactionManagement
@ComponentScans(value = {
        @ComponentScan("com.example.lumberstore.repository"),
        @ComponentScan("com.example.lumberstore.service"),
        @ComponentScan("com.example.lumberstore.security"),
        @ComponentScan("com.example.lumberstore.validation")
})
public class RootConfig {

    @Autowired
    private Environment environment;

    @Bean
    public LocalSessionFactoryBean getSessionFactory() {

        LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();

        Properties properties = new Properties();
        // Setting JDBC properties
        properties.put(org.hibernate.cfg.Environment.DRIVER, environment.getProperty("mysql.driver"));
        properties.put(org.hibernate.cfg.Environment.URL, environment.getProperty("mysql.jdbcUrl"));
        properties.put(org.hibernate.cfg.Environment.USER, environment.getProperty("mysql.username"));
        properties.put(org.hibernate.cfg.Environment.PASS, environment.getProperty("mysql.password"));

        // Setting Hibernate properties
        properties.put(org.hibernate.cfg.Environment.SHOW_SQL, true);
        properties.put(org.hibernate.cfg.Environment.HBM2DDL_AUTO, environment.getProperty("hibernate.hbm2ddl.auto"));

        // Setting C3P0 properties
        properties.put(org.hibernate.cfg.Environment.C3P0_MIN_SIZE, environment.getProperty("hibernate.c3p0.min_size"));
        properties.put(org.hibernate.cfg.Environment.C3P0_MAX_SIZE, environment.getProperty("hibernate.c3p0.max_size"));
        properties.put(org.hibernate.cfg.Environment.C3P0_ACQUIRE_INCREMENT, environment.getProperty("hibernate.c3p0.acquire_increment"));
        properties.put(org.hibernate.cfg.Environment.C3P0_TIMEOUT, environment.getProperty("hibernate.c3p0.timeout"));
        properties.put(org.hibernate.cfg.Environment.C3P0_MAX_STATEMENTS, environment.getProperty("hibernate.c3p0.max_statements"));

        sessionFactoryBean.setHibernateProperties(properties);
        sessionFactoryBean.setPackagesToScan("com.e_commerceSystem.entities");

        return sessionFactoryBean;
    }

    @Bean
    public HibernateTransactionManager getTransactionManager() {

        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
        transactionManager.setSessionFactory(getSessionFactory().getObject());
        return transactionManager;
    }
}
