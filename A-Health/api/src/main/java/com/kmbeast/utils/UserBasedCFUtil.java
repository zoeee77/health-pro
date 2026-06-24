package com.kmbeast.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.*;
import java.util.stream.Collectors;

public class UserBasedCFUtil {

    private static final int TOP_K_NEIGHBORS = 20;

    private final Map<Integer, Map<Integer, Double>> userItemMatrix;

    public UserBasedCFUtil(Map<Integer, Map<Integer, Double>> userItemMatrix) {
        this.userItemMatrix = userItemMatrix;
    }

    public double cosineSimilarity(Map<Integer, Double> user1, Map<Integer, Double> user2) {
        double dotProduct = 0.0;
        double norm1 = 0.0, norm2 = 0.0;
        for (Integer item : user1.keySet()) {
            if (user2.containsKey(item)) {
                dotProduct += user1.get(item) * user2.get(item);
            }
            norm1 += Math.pow(user1.get(item), 2);
        }
        for (Double value : user2.values()) {
            norm2 += Math.pow(value, 2);
        }
        double denominator = Math.sqrt(norm1) * Math.sqrt(norm2);
        if (denominator == 0) return 0.0;
        return dotProduct / denominator;
    }

    public List<Integer> recommendItems(int targetUserId, int topN) {
        Map<Integer, Double> targetUser = userItemMatrix.get(targetUserId);
        if (targetUser == null || targetUser.isEmpty()) {
            return new ArrayList<>();
        }

        Set<Integer> interactedItems = getInteractedItems(targetUser);

        List<SimilarUser> allUsers = new ArrayList<>();
        for (Integer otherId : userItemMatrix.keySet()) {
            if (otherId.equals(targetUserId)) continue;
            allUsers.add(new SimilarUser(otherId,
                    cosineSimilarity(targetUser, userItemMatrix.get(otherId))));
        }
        Collections.sort(allUsers);

        Map<Double, List<Integer>> predictedScores = new LinkedHashMap<>();
        int count = 0;
        for (SimilarUser simUser : allUsers) {
            if (count >= TOP_K_NEIGHBORS) break;
            for (Map.Entry<Integer, Double> entry :
                    userItemMatrix.get(simUser.userId).entrySet()) {
                if (!interactedItems.contains(entry.getKey()) && entry.getValue() > 0) {
                    predictedScores.computeIfAbsent(
                            entry.getValue() * simUser.similarity,
                            k -> new ArrayList<>()).add(entry.getKey());
                }
            }
            count++;
        }

        return predictedScores.entrySet().stream()
                .sorted(Map.Entry.<Double, List<Integer>>comparingByKey().reversed())
                .flatMap(e -> e.getValue().stream())
                .limit(topN)
                .collect(Collectors.toList());
    }

    private Set<Integer> getInteractedItems(Map<Integer, Double> ratings) {
        return ratings.entrySet().stream()
                .filter(e -> e.getValue() != null && e.getValue() > 0)
                .map(Map.Entry::getKey)
                .collect(Collectors.toSet());
    }

    private static class SimilarUser implements Comparable<SimilarUser> {
        int userId;
        double similarity;

        SimilarUser(int userId, double similarity) {
            this.userId = userId;
            this.similarity = similarity;
        }

        @Override
        public int compareTo(SimilarUser other) {
            return Double.compare(other.similarity, this.similarity);
        }
    }

    @Setter
    @Getter
    @AllArgsConstructor
    public static class Score {
        private Integer userId;
        private Integer itemId;
        private Double score;
    }

    public static Map<Integer, Map<Integer, Double>> buildUserItemMatrix(
            List<Integer> itemIds, List<Score> scoreVOS) {
        Set<Integer> allIds = new HashSet<>(itemIds);
        Set<Integer> allUserIds = new HashSet<>();
        for (Score s : scoreVOS) allUserIds.add(s.getUserId());

        Map<Integer, Map<Integer, Double>> matrix = new HashMap<>();
        for (Integer uid : allUserIds) {
            Map<Integer, Double> scores = new HashMap<>();
            for (Integer iid : allIds) scores.put(iid, 0.0);
            matrix.put(uid, scores);
        }
        for (Score s : scoreVOS)
            matrix.computeIfAbsent(s.getUserId(), k -> new HashMap<>())
                    .put(s.getItemId(), s.getScore());
        return matrix;
    }
}
