package weaver.interfaces.yaphets.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import weaver.general.Util;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.DetailTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Row;

public class ActionMapUtil {
	private RequestInfo request;
	public ActionMapUtil(RequestInfo request) {
		this.request = request;
	}
	
	public Map getDataMap(){
		Map dataMap = new HashMap();
		
		Property[] properties = request.getMainTableInfo().getProperty();	
		if(properties.length > 0)
		{
			for (int i = 0; i < properties.length; i++) {
				String name = properties[i].getName(); 
				String value = Util.null2String(properties[i].getValue()); 
				dataMap.put(name.toLowerCase(), value);
			}
		}
		return dataMap;
	}
	
	public ArrayList<HashMap> getMXDataMap(RequestInfo request,int Mxindex){
		ArrayList detailArrayList = new ArrayList();
		DetailTableInfo di = request.getDetailTableInfo();
		DetailTable detailTable = di.getDetailTable(Mxindex-1); 
		Row[] rows = detailTable.getRow(); 
		for (int m = 0; m < rows.length; m++){
			Cell[] cell = rows[m].getCell();
			HashMap ItemMap = new HashMap();
			for (int n = 0; n < cell.length; n++){
				String value = cell[n].getValue();
				String name = cell[n].getName();
				ItemMap.put(name.toLowerCase(), value);
			}
			detailArrayList.add(ItemMap);
		}
		return detailArrayList;
	}
}
