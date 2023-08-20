package com.example.rwaprojekat.dto;

import java.util.List;

public class QuestionRequest {
    private String id;

    private String text;

    private int timeToAnswer;

    private int points;

    private int questionNumber;

    private List<AnswerRequest> answerRequests;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getTimeToAnswer() {
        return timeToAnswer;
    }

    public void setTimeToAnswer(int timeToAnswer) {
        this.timeToAnswer = timeToAnswer;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public List<AnswerRequest> getAnswerRequests() {
        return answerRequests;
    }

    public void setAnswerRequests(List<AnswerRequest> answerRequests) {
        this.answerRequests = answerRequests;
    }

    public int getQuestionNumber() {
        return questionNumber;
    }

    public void setQuestionNumber(int questionNumber) {
        this.questionNumber = questionNumber;
    }
}
