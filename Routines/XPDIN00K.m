XPDIN00K ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,51,2,"D")
 ;;=10^32^30^20
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,51,2,"N")
 ;;=5^1,54^1,54^5^1,54^^^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,51,5,"D")
 ;;=8^32^30^12
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,51,5,"N")
 ;;=0^2^2^0^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,51,"PTB")
 ;;=9.6,1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,51,"PTB",1)
 ;;=S X=$$GET^DDSVAL(9.6,.DA,1),DA=X
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,54)
 ;;=11^2^9.6^^e^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,54,1,"D")
 ;;=12^32^3^20
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,54,1,"N")
 ;;=2,51^0^0^2,51^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,67)
 ;;=4^2^9.6^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,67,2,"D")
 ;;=5^9^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,67,3,"D")
 ;;=^^^^6^2^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",8,"FIRST")
 ;;=5,51
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,0,0,"N")
 ;;=1,84^1,55^1,55^1,84^1,55
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,55)
 ;;=3^3^9.6^^e^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,55,1,"D")
 ;;=5^32^3^21
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,55,1,"N")
 ;;=0^2^2^0^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,55,2,"D")
 ;;=7^32^44^22
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,55,2,"N")
 ;;=1^1,84^1,84^1^1,84
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,84)
 ;;=10^3^9.66^^e^^4^^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,84,1,"D")
 ;;=11^4^4^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,84,1,"N")
 ;;=2,55^0^0^2,55^0^1,-1^1,+1^1,+1^1,-1^1,+1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",9,"FIRST")
 ;;=1,55
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",10,0,0,"N")
 ;;=1,85^1,85^1,85^1,85^1,85
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",10,56)
 ;;=4^5^9.66^^e^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",10,85)
 ;;=5^4^9.661^^e^^2^^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",10,85,1,"D")
 ;;=5^5^4^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",10,85,1,"N")
 ;;=0^0^0^0^0^1,-1^1,+1^1,+1^1,-1^1,+1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",10,"FIRST")
 ;;=1,85
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",11,0,0,"N")
 ;;=1,60^1,60^1,60^1,60^1,60
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",11,60)
 ;;=6^3^9.641^^e^^6^^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",11,60,1,"D")
 ;;=6^3^45^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",11,60,1,"N")
 ;;=0^0^0^0^0^1,-1^1,+1^1,+1^1,-1^1,+1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",11,62)
 ;;=5^3^9.64^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",11,"FIRST")
 ;;=1,60
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",12,0,0,"N")
 ;;=1,61^1,61^1,61^1,61^1,61
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",12,61)
 ;;=7^4^9.6411^^e^^6^^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",12,61,1,"D")
 ;;=7^4^45^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",12,61,1,"N")
 ;;=0^0^0^0^0^1,-1^1,+1^1,+1^1,-1^1,+1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",12,63)
 ;;=6^3^9.641^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",12,"FIRST")
 ;;=1,61
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,0,0,"N")
 ;;=7,64^2,64^2,64^7,64^2,64
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64)
 ;;=5^1^9.64^^e^^^^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,2,"D")
 ;;=7^21^15^222.8
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,2,"N")
 ;;=0^4^4^0^4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,3,"D")
 ;;=11^21^30^222.6
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,3,"N")
 ;;=4^7^7^5^7
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,4,"D")
 ;;=9^21^3^222.5
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,4,"N")
 ;;=2^3^5^2^5
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,5,"D")
 ;;=9^68^3^222.9
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,5,"N")
 ;;=2^3^3^4^3
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,7,"D")
 ;;=14^3^72^224
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,64,7,"N")
 ;;=3^0^0^3^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",13,"FIRST")
 ;;=2,64
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,0,0,"N")
 ;;=3,65^1,66^1,66^3,65^1,66
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,45)
 ;;=0^0^9.6^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,45,2,"D")
 ;;=1^6^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,45,4,"D")
 ;;=^^^^2^0^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,65)
 ;;=0^0^9.6^^e^^^^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,65,2,"D")
 ;;=14^26^30^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,65,2,"N")
 ;;=1,66^3^3^1,66^3
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,65,3,"D")
 ;;=16^26^3^5
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,65,3,"N")
 ;;=2^0^0^2^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,66)
 ;;=4^0^9.62^^e^^6^^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,66,1,"D")
 ;;=5^2^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,66,1,"N")
 ;;=0^2,65^2,65^0^2,65^1,-1^1,+1^1,+1^1,-1^1,+1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",14,"FIRST")
 ;;=1,66
