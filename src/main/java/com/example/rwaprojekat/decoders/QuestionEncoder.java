package com.example.rwaprojekat.decoders;

import com.example.rwaprojekat.model.Message;
import com.example.rwaprojekat.model.Question;
import com.google.gson.Gson;
import jakarta.websocket.*;

public class QuestionEncoder implements Encoder.Text<Question>  {
    private static Gson gson = new Gson();

    @Override
    public String encode(Question question) throws EncodeException {
        return gson.toJson(question);
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
