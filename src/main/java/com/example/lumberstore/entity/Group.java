package com.example.lumberstore.entity;


import javax.persistence.*;
import javax.xml.bind.annotation.XmlTransient;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "GROUPS")
@NamedQueries({
        @NamedQuery(name = "Groups.findAll", query = "SELECT g FROM Group g"),
        @NamedQuery(name = "Groups.findById", query = "SELECT g FROM Group g WHERE g.id = :id"),
        @NamedQuery(name = "Groups.findByName", query = "SELECT g FROM Group g WHERE g.name = :name"),
        @NamedQuery(name = "Groups.findByDescription", query = "SELECT g FROM Group g WHERE g.description = :description")})
public class Group {
    @Id
    private int id;
    private String name;
    private String description;
    @ManyToMany(mappedBy = "groupsList")
    @XmlTransient
    private List<User> personList;

    public Group() {
    }

    public Group(int id) {
        this.id = id;
    }

    public Group(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlTransient
    public List<User> getPersonList() {
        return personList;
    }

    public void setPersonList(List<User> personList) {
        this.personList = personList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Group groups = (Group) o;
        return id == groups.id && Objects.equals(name, groups.name) && Objects.equals(description, groups.description) && Objects.equals(personList, groups.personList);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, description, personList);
    }

    @Override
    public String toString() {
        return "Groups{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", personList=" + personList +
                '}';
    }
}
