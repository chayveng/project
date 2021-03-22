package com.example.project_api.models.tables;

import java.util.List;

class Person {
    Person(String name, int age, boolean isMarried, List<String> hobbies,
           List<Person> kids) {
        this.name = name;
        this.age = age;
        this.isMarried = isMarried;
        this.hobbies = hobbies;
        this.kids = kids;
    }

    Person(String name, int age) {
        this(name, age, false, null, null);
    }

    private String name;
    private Integer age;
    private Boolean isMarried;
    private List<String> hobbies;
    private List<Person> kids;

    // getters and setters

    @Override
    public String toString() {
        return "Person{" +
                "name='" + name + '\'' +
                ", age=" + age +
                ", isMarried=" + isMarried +
                ", hobbies=" + hobbies +
                ", kids=" + kids +
                '}';
    }
}