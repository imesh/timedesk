--
-- Create Employee Allocation View
--

CREATE OR REPLACE VIEW employee_allocation AS
SELECT (CAST(CONCAT(e.id, p.id, phm.id) AS CHAR)) as 'id', e.version, e.id as 'emp_id', e.employee_id, p.id as 'p_id', p.name, phm.id as 'phm_id', phm.phase_member_id, phm.start_date, phm.end_date, phm.allocation 
FROM employee e, project_member m, project_phase_member phm, project p
WHERE e.id = m.employee_id AND m.id = phm.member_id AND m.project_id = p.id