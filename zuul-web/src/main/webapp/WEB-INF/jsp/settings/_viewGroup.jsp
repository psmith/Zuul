<%--@elvariable id="group" type="org.devnull.zuul.data.model.SettingsGroup"--%>
<%--@elvariable id="environment" type="org.devnull.zuul.data.model.Environment"--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<security:authorize var="isAdmin" access="hasRole('ROLE_ADMIN')"/>

<c:url var="downloadUrl"
       value="/settings/${fn:escapeXml(environment.name)}/${fn:escapeXml(group.name)}.properties"/>
<a class="btn btn-primary descriptive" href="${downloadUrl}" title="Download"
   data-content="Use this URL in your application.">
    <i class="icon-white icon-download-alt"></i>
    ${fn:escapeXml(environment.name)}
</a>
<c:if test="${isAdmin}">
    <c:url var="addUrl"
           value="/settings/${fn:escapeXml(environment.name)}/${fn:escapeXml(group.name)}/create/entry"/>
    <a class="btn btn-primary descriptive" href="${addUrl}" title="Add Entry"
       data-content="Create a new key value pair">
        <i class="icon-white icon-plus"></i>
        Create Entry
    </a>
    <a class="btn btn-danger descriptive delete-group-link pull-right" href="#" title="Warning"
       data-env="${fn:escapeXml(environment.name)}" data-group="${fn:escapeXml(group.name)}"
       data-content="This will delete the ${environment.name} settings group. This operation cannot be undone.">
        <i class="icon-white icon-trash"></i>
        Delete
    </a>
</c:if>

<table class="table table-bordered table-condensed" style="margin-bottom: 10em; margin-top: 1em;">
    <thead>
    <tr>
        <th style="width: 15%; white-space: nowrap;">Actions</th>
        <th style="width: 30%">Key</th>
        <th style="width: 55%">Value</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="e" items="${group.entries}">
        <tr class="entry">
            <td>
                <c:if test="${isAdmin}">
                    <div class="btn-group">
                        <a class="btn btn-small dropdown-toggle" data-toggle="dropdown"
                           href="#">
                            <i class="icon-cog"></i>
                            Action
                            <span class="caret"></span>
                        </a>
                        <ul class="settings-entry dropdown-menu">
                            <li>
                                <a href="javascript:void(0);" class="encrypt-link" data-id="${e.id}"
                                   data-encrypted="${e.encrypted}">
                                    <i class="icon-lock"></i>
                                        ${e.encrypted ? 'Decrypt' : 'Encrypt'}
                                </a>
                            </li>
                            <li>
                                <a href="#" class="edit-link" data-id="${e.id}">
                                    <i class="icon-edit"></i>
                                    Edit
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#" class="delete-link" data-id="${e.id}">
                                    <i class="icon-trash"></i>
                                    Delete
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${!isAdmin}">
                    <a class="btn btn-small disabled">Disabled</a>
                </c:if>
            </td>
            <td class="key">${e.key}</td>
            <td class="value">${e.value}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>