/**
 * DocService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package weaver.interfaces.yaphets.webservice.docService;

public interface DocService extends javax.xml.rpc.Service {
    public String getDocServiceHttpPortAddress();

    public weaver.interfaces.yaphets.webservice.docService.DocServicePortType getDocServiceHttpPort() throws javax.xml.rpc.ServiceException;

    public weaver.interfaces.yaphets.webservice.docService.DocServicePortType getDocServiceHttpPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
