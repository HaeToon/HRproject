package com.hrproject.hrproject.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Builder;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HrmPageDto {
    private int start;
    private int end;
    private String search;
    private String searchWord;
}
