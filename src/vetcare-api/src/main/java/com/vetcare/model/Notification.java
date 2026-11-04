package com.vetcare.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "notifications")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, length = 30)
    private String type;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;

    @Column(name = "scheduled_at", nullable = false)
    @Builder.Default
    private LocalDateTime scheduledAt = LocalDateTime.now();

    @Column(name = "is_sent", nullable = false)
    @Builder.Default
    private Boolean isSent = false;

    @Column(nullable = false, length = 20)
    @Builder.Default
    private String channel = "IN_APP";

    @Column(name = "sent_at")
    private LocalDateTime sentAt;
}

