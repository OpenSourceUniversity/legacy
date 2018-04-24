format 214

classinstance 128130 class_ref 128514 // Authority
  name ""   xyz 124 4 2000 life_line_z 2000
classinstance 128258 class_ref 128130 // Academia
  name ""   xyz 249 4 2000 life_line_z 2000
classinstance 129154 class_ref 128002 // Learner
  name ""   xyz 519 4 2000 life_line_z 2000
classinstance 129666 class_ref 128386 // Course
  name ""   xyz 402 4 2000 life_line_z 2000
classinstance 130818 class_ref 128258 // Business
  name ""   xyz 649 4 2000 life_line_z 2000
durationcanvas 128770 classinstance_ref 128130 // :Authority
  xyzwh 155 63 2010 11 61
end
durationcanvas 128898 classinstance_ref 128258 // :Academia
  xyzwh 284 74 2010 11 44
end
durationcanvas 129282 classinstance_ref 128258 // :Academia
  xyzwh 284 232 2010 11 33
end
durationcanvas 129410 classinstance_ref 129154 // :Learner
  xyzwh 547 225 2010 11 42
end
durationcanvas 129794 classinstance_ref 128258 // :Academia
  xyzwh 284 144 2010 11 47
end
durationcanvas 129922 classinstance_ref 129666 // :Course
  xyzwh 428 129 2010 11 42
end
durationcanvas 130946 classinstance_ref 130818 // :Business
  xyzwh 681 299 2010 11 40
end
durationcanvas 131074 classinstance_ref 129154 // :Learner
  xyzwh 547 300 2010 11 39
end
durationcanvas 131330 classinstance_ref 129154 // :Learner
  xyzwh 547 390 2010 11 40
end
durationcanvas 131458 classinstance_ref 130818 // :Business
  xyzwh 681 390 2010 11 26
end
msg 129026 synchronous
  from durationcanvas_ref 128770
  to durationcanvas_ref 128898
  yz 86 2015 msg operation_ref 128514 // "authorize(in authority : Authority)"
  show_full_operations_definition default show_class_of_operation default drawing_language default show_context_mode default
  label_xy 190 67
msg 129538 synchronous
  from durationcanvas_ref 129282
  to durationcanvas_ref 129410
  yz 239 2015 msg operation_ref 128386 // "certify()"
  show_full_operations_definition default show_class_of_operation default drawing_language default show_context_mode default
  label_xy 334 222
msg 130050 synchronous
  from durationcanvas_ref 129794
  to durationcanvas_ref 129922
  yz 144 2015 msg operation_ref 128642 // "addToDegree(in academia : Academia)"
  show_full_operations_definition default show_class_of_operation default drawing_language default show_context_mode default
  label_xy 311 127
msg 131202 synchronous
  from durationcanvas_ref 130946
  to durationcanvas_ref 131074
  yz 300 2015 msg operation_ref 128770 // "requestContact(in business : Business)"
  show_full_operations_definition default show_class_of_operation default drawing_language default show_context_mode default
  label_xy 564 280
msg 131586 synchronous
  from durationcanvas_ref 131330
  to durationcanvas_ref 131458
  yz 390 2015 msg operation_ref 128898 // "provideAccess(in learner : Learner)"
  show_full_operations_definition default show_class_of_operation default drawing_language default show_context_mode default
  label_xy 566 371
end
