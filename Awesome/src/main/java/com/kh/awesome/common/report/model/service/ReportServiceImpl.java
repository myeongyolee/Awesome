package com.kh.awesome.common.report.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.common.report.model.dao.ReportDAO;
import com.kh.awesome.common.report.model.vo.Report;

@Service
public class ReportServiceImpl implements ReportService {
	
	@Autowired
	ReportDAO reportDAO;

	@Override
	public int insertReport(Report report) {
		return reportDAO.insertReport(report);
	}
}
