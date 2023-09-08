package com.example.springdeploy;

import java.util.Arrays;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ProfileController {

    private final Environment env;

    @GetMapping("/profile")
    public String profile() {
        List<String> profiles = Arrays.asList(env.getActiveProfiles());
        System.out.println(profiles.toString());
        List<String> realProfiles = Arrays.asList("real1", "real2");
        String defaultProfile = profiles.isEmpty() ? "default" : profiles.get(0);

        return profiles.stream().filter(realProfiles::contains).findAny().orElse(defaultProfile);
    }
}
