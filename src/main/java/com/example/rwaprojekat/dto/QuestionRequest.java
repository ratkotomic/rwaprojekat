package com.example.rwaprojekat.dto;

import java.util.List;

public class QuestionRequest {

    private String text;

    private int timeToAnswer;

    private int points;

    private List<AnswerRequest> answerRequests;

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
}
