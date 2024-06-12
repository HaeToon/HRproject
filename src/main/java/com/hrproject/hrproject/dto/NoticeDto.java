package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeDto {
    private int empno;
    private int notice_no;
    private String writer;
    private String subject;
    private String content;
    private String regdate;
    private int hit;
}
