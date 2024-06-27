package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommunityDto {
    private int communityNo;
    private String category;
    private String title;
    private String author;
    private String createdDate;
    private String content;
    private int views;
}