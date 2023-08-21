package com.example.rwaprojekat.decoders;

import com.example.rwaprojekat.model.Question;
import com.google.gson.Gson;
import jakarta.websocket.DecodeException;
import jakarta.websocket.Decoder;
import jakarta.websocket.EndpointConfig;


public class QuestionDecoder implements Decoder.Text<Question> {

    private static Gson gson = new Gson();

    @Override
    public Question decode(String s) throws DecodeException {
        return gson.fromJson(s, Question.class);
    }

    @Override
    public boolean willDecode(String s) {
        return (s != null);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {
        // Custom initialization logic
    }

    @Override
    public void destroy() {
        // Close resources
    }
}
