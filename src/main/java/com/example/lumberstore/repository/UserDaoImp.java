package com.example.lumberstore.repository;

import com.example.lumberstore.entity.Role;
import com.example.lumberstore.repository.interfaces.UserDao;
import com.example.lumberstore.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.Optional;

@Repository
public class UserDaoImp implements UserDao {

private final SessionFactory sessionFactory;

    @Autowired
    public UserDaoImp(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public User findUserByUsername(String username) {

        List<User> results;
            Session session = sessionFactory.getCurrentSession();
            Query<User> query;
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<User> criteriaQuery = criteriaBuilder.createQuery(User.class);
            Root<User> root = criteriaQuery.from(User.class);
            criteriaQuery.select(root).where(criteriaBuilder.equal(root.get("username"), username));

            query = session.createQuery(criteriaQuery);
            results = query.getResultList();

        User user = null;
        if(! results.isEmpty()){
            user = results.get(0);
        }

        return user;
    }

    @Override
    public Optional<User> findUserByEmail(String email) {

        Optional<User> user = sessionFactory.getCurrentSession()
                .createNamedQuery("get_user_by_email", User.class)
                .setParameter("email", email)
                .getResultList()
                .stream().findFirst();
        return user;
    }

    @Override
    public void saveUser(User user) {
        sessionFactory.getCurrentSession().save(user);
    }

    @Override
    public Role getUserRole() {

        Optional<Role> role = sessionFactory.getCurrentSession()
                .createQuery("from Role where role=:role")
                .setParameter("role", "ROLE_USER")
                .getResultList()
                .stream().findFirst();

        return role.get();
    }
}
