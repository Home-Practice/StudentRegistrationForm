<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Form</title>
</head>
<body>
	<h2>Student Registration Form:</h2>

	<form:form action="handleStudent" method="Post"
		modelAttribute="student">
		<table>

			<tr>
				<td>First Name:</td>
				<td><form:input path="firstName" /></td>
			</tr>

			<tr>
				<td>Last Name:</td>
				<td><form:input path="lastName" /></td>
			</tr>

			<tr>
				<td>Email:</td>
				<td><form:input path="email" /></td>
			</tr>

			<tr>
				<td>Gender:</td>
				<td><form:radiobutton path="gender" value="male" />Male</td>
				<td><form:radiobutton path="gender" value="female" />Female</td>
			</tr>

			<tr>
				<td>Courses:</td>
				<td><form:select path="courses">
						<form:option value="">- Select -</form:option>
						<form:option value="java">Java</form:option>
						<form:option value=".net">. Net</form:option>
						<form:option value="testing">Testing</form:option>
					</form:select></td>
			</tr>

			<tr>
				<td>Timing:</td>
				<td><form:checkbox path="timing" value="morning" />Morning</td>
				<td><form:checkbox path="timing" value="afternoon" />Afternoon</td>
			</tr>

			<tr>

				<td><input type="Submit" value="Register" /></td>
			</tr>

		</table>

	</form:form>


</body>
</html>