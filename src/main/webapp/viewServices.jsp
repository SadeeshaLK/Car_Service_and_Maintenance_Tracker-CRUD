<table border="1">
    <tr>
        <th>Service ID</th>
        <th>Car ID</th>
        <th>Service Date</th>
        <th>Service Type</th>
        <th>Service Cost</th>
    </tr>
    <c:forEach items="${services}" var="service">
        <tr>
            <td>${service.serviceId}</td>
            <td>${service.carId}</td>
            <td>${service.serviceDate}</td>
            <td>${service.serviceType}</td>
            <td>${service.serviceCost}</td>
        </tr>
    </c:forEach>
</table>