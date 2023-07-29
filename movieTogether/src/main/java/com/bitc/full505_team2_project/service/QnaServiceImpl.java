package com.bitc.full505_team2_project.service;

import com.bitc.full505_team2_project.common.FileUtils;
import com.bitc.full505_team2_project.dto.*;
import com.bitc.full505_team2_project.mapper.QnaMapper;
import com.github.pagehelper.PageHelper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.ArrayList;
import java.util.List;

@Service
public class QnaServiceImpl implements QnaService{

  @Autowired
  private QnaMapper qnaMapper;
  @Autowired
  private FileUtils fileUtils;

  /* 문의 게시글 목록 불러오기 */
  @Override
  public List<QnaDto> selectQnaList(int pageNum) throws Exception {
    PageHelper.startPage(pageNum, 10);
    return qnaMapper.selectQnaList();
  }

  // 검색 키워드 글 목록
  public List<QnaDto> selectSearchList(int pageNum, String searchKey, String searchItem) throws Exception{
    PageHelper.startPage(pageNum, 10);
    return qnaMapper.selectSearchList(searchKey, searchItem);
  }

  /* 카테고리 길이 */
  public List<CategoryDto> categoryList() throws Exception{
    return qnaMapper.categoryList();
  }

  /* 문의 게시글 카테고리별 목록 불러오기 */
  @Override
  public List<QnaDto> selectQnaCategoryList(int qnaCategory) throws Exception{
    return qnaMapper.selectQnaCategoryList(qnaCategory);
  }

  /* 문의 게시글 상세 페이지 */
  @Override
  public QnaDto selectQnaDetail(int qnaPk) throws Exception {

    /*
     * 1. 컨트롤러에서 전달된 게시물 번호 가져오기
     * 2. mapper를 사용하여 DB에서 지정한 게시물의 조회수 업데이트
     * 3. mapper를 사용하여 DB에서 지정한 게시물 정보 가져오기
     * 4. mapper를 사용하여 DB에서 지정한 게시물의 첨부파일 목록 불러오기
     * 5. 가져온 파일 목록을 BoardDto 타입에 저장
     * 6. 가져온 게시물 정보를 컨트롤러로 리턴 */

    qnaMapper.updateHitCount(qnaPk);

    // 게시물 정보 dto 객체에 저장
    QnaDto qnaBoard = qnaMapper.selectQnaDetail(qnaPk);

    // 첨부파일 목록 가져오기
    List<BoardFileDto> boardFileList = qnaMapper.selectQnaFileList(qnaPk);

    // 객체에 첨부파일 리스트 추가
    qnaBoard.setFileList(boardFileList);

    return qnaBoard;
  }

  /* 문의 게시글 게시글 작성 */
  @Override
  public void insertQna(QnaDto qnaBoard, MultipartHttpServletRequest uploadFiles) throws Exception {
    /* 1. 컨트롤러에서 전달된 데이터 가져오기
     * 2. mapper를 사용해서 db에 등록(게시글, 파일 정보 분리)
     * */

    qnaMapper.insertQna(qnaBoard);

    List<BoardFileDto> fileList = fileUtils.parseFileInfo(qnaBoard.getQnaPk(), 2, uploadFiles);

    // CollectionUtils : 스프링 프레임워크에서 제공하는 클래스
    if(CollectionUtils.isEmpty(fileList) == false){
      qnaMapper.insertQnaFileList(fileList);
    }

  }

  @Override
  public void updateQna(QnaDto qnaBoard) throws Exception {
    qnaMapper.updateQna(qnaBoard);
  }

  @Override
  public void deleteQna(int qnaPk) throws Exception {
    qnaMapper.deleteQna(qnaPk);
  }

  // 코멘트 입력하기
  @Override
  public void insertComment(CommentDto comment) throws Exception {
    qnaMapper.insertComment(comment);
  }

  // 해당 게시글 코멘트 들고오기
  @Override
  public List<CommentDto> selectCommentList(@Param("commentNum") int qnaPk) throws Exception {
    return qnaMapper.selectCommentList(qnaPk);
  }

  // 코멘트 삭제하기 (작성자, 관리자)

  @Override
  public void deleteComment(@Param("commentNum") int qnaPk, @Param("commentPk") int commentPk) throws Exception {
    qnaMapper.deleteComment(qnaPk, commentPk);
  }

  @Override
  public BoardFileDto selectQnaFileInfo(int qnaFileId, int qnaPk) throws Exception {
    return qnaMapper.selectQnaFileInfo(qnaFileId, qnaPk);
  }
}
