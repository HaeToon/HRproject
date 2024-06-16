package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeDto {
    private int notice_no;
    private String title;
    private String author;
    private String created_date;
    private String content;
    private int views;


}
