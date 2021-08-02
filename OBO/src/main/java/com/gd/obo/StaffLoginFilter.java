package com.gd.obo;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter("/staff/*")
public class StaffLoginFilter implements Filter{
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//요청전
		log.debug("===== 필터 요청 전");
		HttpSession session = null;
		if(request instanceof HttpServletRequest) { //request를 HttpServletRequest로 형변환 할 수 있나?
			session = ((HttpServletRequest)request).getSession(); //형변환 되면 session ID 가져오기
		}
		//매니저 홈 이동 필터
		if(session.getAttribute("loginStaff")==null) { //session ID에 loginManager 있는지 확인 없다면
			if(response instanceof HttpServletResponse){ //response도 형변환 할 수 있는지 확인
				((HttpServletResponse)response).sendRedirect("/obo/s/"); //매니저 홈으로 이동한다.
			}
			return;
		}
		chain.doFilter(request, response);
		//요청후
		log.debug("===== staff 로그인 필터 작동!");
		
	}
}

