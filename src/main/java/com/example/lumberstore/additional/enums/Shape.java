package com.example.lumberstore.additional.enums;

public enum Shape {

    ARBITRARY("arbitrary") {

        @Override
        public float getSquare(int a, int b) {

            return (float) (a * b / 1000000.);
        }

        @Override
        public float getPerimeter(int a, int b) {

            return (float) ((a + b) / 1000. * 2);
        }
    },

    RECTANGLE("rectangle") {

        @Override
        public float getSquare(int a, int b) {

            return (float) (a * b / 1000000.);
        }

        @Override
        public float getPerimeter(int a, int b) {

            return (float) ((a + b) / 1000. * 2);
        }
    },
    RIGHT_TRIANGLE("rightTriangle") {

        @Override
        public float getSquare(int a, int b) {

            return (float) (a * b / 1000000. / 2.);
        }

        @Override
        public float getPerimeter(int a, int b) {

            return (float) (Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2)) + a + b);
        }
    },
    CIRCLE("circle") {

        @Override
        public float getSquare(int a, int b) {

            return (float) (a * b / 1000000.);
        }

        @Override
        public float getPerimeter(int a, int b) {

            return (float) ((a / 2. + b / 2.) * Math.PI);
        }
    };

    private String name;

    Shape(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public abstract float getSquare(int a, int b);
    public abstract float getPerimeter(int a, int b);
}
