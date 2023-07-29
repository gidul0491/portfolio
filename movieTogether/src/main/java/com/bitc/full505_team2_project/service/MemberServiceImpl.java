package com.bitc.full505_team2_project.service;

import com.bitc.full505_team2_project.dto.MemberDao;
import com.bitc.full505_team2_project.dto.MemberDto;
import com.bitc.full505_team2_project.mapper.MemberMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


//interface를 구현한 클래스 만듬
//@Service 어노테이션을 붙여 이 클래스가 서비스 클래스라는 것을 알려줌
//Service가 DAO호출함 하지만 매퍼를 사용하기 때문에 DAO 사용 X , 파일 사용 X

@Service //service bean으로 등록
public class MemberServiceImpl implements MemberService{

//    @Inject
//    MemberDao memberDao;

    @Autowired
    private MemberMapper memberMapper;


    @Override
    public void memberJoin(MemberDto member) {
       memberMapper.memberJoin(member);
    }

    @Override
    public int loginCheck(String memberId,String memberPw) {

        return memberMapper.loginCheck(memberId,memberPw);
//        String name = memberDao.loginCheck(dto);
//        if (name != null) { //세션 변수 저장
//            session.setAttribute("memberId",dto.getMemberId());
//            session.setAttribute("name",name);
//        }
//        return name;
    }

    @Override
    public void logout(HttpSession session) {
        session.invalidate(); //세션초기화
    }

    @Override
    public MemberDto selectMember(String memberId,String memberPw) {
       return memberMapper.selectMember(memberId,memberPw);


    }

    @Override
    public int IdCheck(String Id1) {
       return memberMapper.IdCheck(Id1);
    }

    @Override
    public void Correction(MemberDto memberDto) {
        memberMapper.Correction(memberDto);
    }

    @Override
    public String selectLikeList(String memberId) {
        return memberMapper.selectLikeList(memberId);
    }
}
