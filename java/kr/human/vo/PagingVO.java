package kr.human.vo;
// 알고리즘은 동일하고 데이터 타입만 다를 경우 제네릭 클래스로 만든다.

import java.util.List;

public class PagingVO<T> {
	private List<T> list;

	private int totalCount;
	private int currentPage;
	private int pageSize;
	private int blockSize;

	private int totalPage;
	private int startNo;
	private int endNo;
	private int startPage;
	private int endPage;

	public PagingVO(int totalCount, int currentPage, int pageSize, int blockSize) {
		super();
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.blockSize = blockSize;
		calc();
	}

	private void calc() {
		if (totalCount < 0) totalCount = 0;
		if (currentPage <= 0) currentPage = 1;
		if (pageSize <= 1) pageSize = 10;
		if (blockSize <= 1) blockSize = 10;

		if (totalCount > 0) {
			totalPage = (totalCount - 1) / pageSize + 1;
			startNo = (currentPage - 1) * pageSize + 1;//오라클이기에 +1을 해줘야 한다
			endNo = startNo + pageSize - 1;
			if(endNo>totalCount) endNo = totalCount;
// 오라클이기에 끝번호가 페이지 총수보다 무조건 작아야하고, totalCount에서 1뺄 필요없다
			startPage = (currentPage-1)/blockSize * blockSize + 1;
			endPage = startPage + blockSize -1;
			if(endPage>totalPage) endPage = totalPage;
		}
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getStartNo() {
		return startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	// 메서드 2개 추가
	public String getPageInfo() {
		String info = "전체 : " + totalCount + "개";
		if(totalCount>0) {
			info += "(" + currentPage + "/" + totalPage + "Page)";
		}
		return info;
	}

	public String getPageList() {
		String pageList="";
		// 시작페이지가 1보다 크면 이전이 있다.
		if(startPage>1) {
			pageList +="[<a href='?p="+(startPage-1)+"&s="+pageSize+"&b="+blockSize+"'>이전</a>] ";
		}
		// 페이지 번호를 찍자
		for(int i=startPage;i<=endPage;i++) {
			// 현재 페이지는 링크를 걸지 않는다.
			if(i==currentPage) {
				pageList += "[" + i + "] ";
			}else {
				pageList +="[<a href='?p="+ i +"&s="+pageSize+"&b="+blockSize+"'>" + i + "</a>] ";
			}
		}
		// 마지막페이지가 전체페이지보다 적다면 다음이 있다.
		if(endPage<totalPage) {
			pageList +="[<a href='?p="+(endPage+1)+"&s="+pageSize+"&b="+blockSize+"'>다음</a>] ";
		}
		return pageList;
	}
	
	@Override
	public String toString() {
		return "PagingVO [list=" + list + ", totalCount=" + totalCount + ", currentPage=" + currentPage + ", pageSize="
				+ pageSize + ", blockSize=" + blockSize + ", totalPage=" + totalPage + ", startNo=" + startNo
				+ ", endNo=" + endNo + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
}
