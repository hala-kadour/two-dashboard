class CreateContactUsParam {
  String token;
  String subject;
  String description;
  String phone;
  CreateContactUsParam({
    required this.token,
    required this.subject,
    required this.description,
    required this.phone,
  });
}

class ShowContactUsParam {
  int seenFilter;
  int approveFilter;
  ShowContactUsParam({required this.seenFilter, required this.approveFilter});
}
