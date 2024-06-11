package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HrmPageDto {
    private int start;
    private int end;
    private String search;
    private String searchWord;
}
