Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.527.1793465165148217591
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:46:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=IHyE1pyL;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=V4oigBCS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGU4OD3197103
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kG8eEnPbmpZ
	XnAL0SHMw5gcFz45/qbO0+zMHllAsJ9Y=; b=IHyE1pyLf2fdaWT7AurFyGfkLEf
	YK7dP/gWvvKRpQyVaFbou2cjHrDujS9pCiXPuZ89oJdbEZgkIwaalVD6Lvv/LbVJ
	AuAhJUXOMXTGfWs3wTTIFZE410b2vYcn+xTF00moVQ8xJW75Mb6PLL2m18bZdn45
	ift9hKxQLU6nXpgDeW7V7spQIPcHvsB8XB40hcXuFaCZwSRVl62IXJizKfJVPDI1
	Z7XRdqwCnwiPStxw5hzRJTjC2/pnkcoiXf2qrRodScc1Rm977Nmg0D1JfZaK+wdT
	MLwPyHRj/JFjgeW0BcxoyMeZMuvgklwShhKWRXPVgie+yAmaCLniEiPE5LQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6hq23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso517245885a.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465163; x=1794069963; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kG8eEnPbmpZXnAL0SHMw5gcFz45/qbO0+zMHllAsJ9Y=;
        b=V4oigBCSLQon3vzl0ZVeUcFBlCQBKGKTcb5JnoZBpXOEQjPkNaJoWAF2pbgRqG+lR6
         sQiYku+oQXBVkNWVEwv6m6uYkKtNJ7zMST4TXwndLAJ8Cj+EF8ryImfMBkZl//bCUUj7
         jBdV4iXx0a7QWzYnT4OKQZFGDUI5eBkfapsCXMQtvKy3QSA8F8GJQoTWYxLrGyn6VbO8
         dREA2YE7NTbtdnqVMBIdVcTg7UkuGsXVioMxy0TfQKVkvfYvs9MOGF0xCkHqyYMVDiS0
         LJv2FovJbf/tfuRrH2joumjgNQuPWiJYdTPhyHgHdAnY9qV9i9nuPn+Ukj25rplnbmDB
         Atwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465163; x=1794069963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kG8eEnPbmpZXnAL0SHMw5gcFz45/qbO0+zMHllAsJ9Y=;
        b=tPaxhrlytjpK5jPZ/a1IvRP2KQT0xgL8wd5LZRT/ctxe69YvLgzZ7SJfJ2nah/Cv7h
         CLeGuN7KPk1/IO9Jt5+p9S65qqgrCKbk7NwBLZ9fGOdX3QSxd6cxOec52ucddzvycM3E
         iNXoFWB+IdIoYjIB36sq2mnnW/68OGy+zX7G/P2+oqQA2HrnwuAspDBPi1gZ3IY1qMBN
         disz2KChfQq+RJcRBZx5yYz6ry8X2a/iY4u4FhByCQvEmsj/yhqbAzkyH97HMGHXYxnQ
         oQJGJ9CvRUKswx/TXE8av9MD8ikNtWCJVMCnkID+3XgE+nJ1YvSyWk5RPWBoZYeNiiGD
         cwBQ==
X-Gm-Message-State: AFq9FYIKpkJS258CMT0fpSSME4+QwxxesbzvpXglrl8equGHhZI9jHm7
	5HuOMF05c3xHfVzGpfwTuYesnCvrLgRMIRqS6lfGaYPA2wEO8rgWgFU6LUzc7SQuCEZRaOO++PK
	4L2LGKw1nGH+4bQLQgfUXkhwhicCRUnDBumTJflJm8BACIzVhSMcfjdxB9ZEGFSCwLU/8dA8aZ3
	oFfjigtbxobw==
X-Gm-Gg: AYBFou3semv4aPt3dHdRfJEKg6ZYgOJSJq4az/z8dz23sSF1GCbYNYMzytATiJOxhr+
	JEc8rzQmGOtuvS0IMk45Y+6dfDtPZttldsUlpqbd8vZvrVi0w6jwmAh1MEzTclxLGLvhg/fGGI2
	DyX88jWiCTePpN0sny8Px9/3n+PE6y+r9RXjT2KBMmOekQFISU0U9OI98c9VzrS8UqWQccDFPPq
	98eRBDXfwoGLG8LyhkgUKysSBpxSBCibJU4SkQ4drfc2gX91HzRA3nlkw7czkU8sanxArWcCzEm
	dwpMqE4sEu7BqUBUME+jyIlc/KV3zpCgT1O0cV7kwd/ULA1+uqvsq0spfjPEpBUp8OHNws0B32V
	4D+hJO4TzurnycBJYLgLwBdGBTbkOtL9oNVuzdyhCgrhsshkxCy6scYK67uwQU50=
X-Received: by 2002:a05:620a:1999:b0:93c:891b:90f1 with SMTP id af79cd13be357-944133ab8aemr1383275885a.26.1793465163121;
        Sat, 31 Oct 2026 09:46:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:93c:891b:90f1 with SMTP id af79cd13be357-944133ab8aemr1383272785a.26.1793465162466;
        Sat, 31 Oct 2026 09:46:02 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:46:01 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 08/10] README: fix the license before the merge
Date: Sat, 31 Oct 2026 16:45:41 +0000
Message-ID: <20261031164543.1668-8-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yn5i-AyKRqATz_bRKdBokrlHlFx3Gz6f
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae61b4b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nBzi43ItJ7eSSC7wROcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: yn5i-AyKRqATz_bRKdBokrlHlFx3Gz6f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX9ezU9gzYf5j+
 ZmLW0lg4+FtQGNlmP7AM7sWlAu2WkF78Bwby+L7he7U4xJYOXWiX+qP3ksjOiWVM9+vTqffG3BC
 NPWFqNxx1IBcNG/44PFDZgogJujzCwU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX7MQjKmQ7cJFl
 tKqLklNjPlnCAuH73QbbMxoqxIcchHigUtlxFJpMPm68qM0nhmLawJQzFDtKZ/08ykU2o1MN1hv
 8MM2i5JEtf6OGoFGAwnyiGsuPIpV+k8AJ+rD1/CCe8Bqr2NFePlMHb+Ukon+mx6AzRn2OVBMYPd
 Ce1gZ/uS8E+27qhiheU+5GwCAWzLZtxsE6Aq7lSaMEq1rdC5dvh480zynZ3hMS85VJ6CSf1N08o
 Q9uytVp+9QoR11PWQQfVLDodY6iEtgJozcpcaNZe7vBjxdaAs+C4OJ8NYH0oyHTpALhl9Os/fDD
 AU51Ehv13Oibg8IvKjVTazKqYi+mm/JPkQ5K3dS2Y0L3RLYcoOu0U3l43rHgT0YgQvjCFc1wElw
 ZMdL0RPMMFJ4jdsHooivwTActbaR3W4X+PdoZ5C1Kok0F1JB9GL/TWAkAqwo+DLzJGUPf7aVsj9
 1eWV39TVTMWx2Lsp6ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5201
Content-Type: text/plain; charset="utf-8"

Change the order of the license syntax fix and
change the work branch name.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/README.md b/README.md
index 57d0770..2e0ff4a 100644
--- a/README.md
+++ b/README.md
@@ -31,30 +31,33 @@ Backporting
 -----------
 
 There are breaking changes in master in the license syntax.
-Because of this we carry a local backport branch
-that follows oe-core/master without any local changes.
+Because of this we carry a local work branch that follows
+oe-core/master without any local changes.
 
 The patches can be backported from openembedded-core in two steps:
 
-First the patch is backported on the backport branch
+First the patch is backported on the work branch
 ```
- git checkout wrynose/linux-firmware-master
+ git checkout wrynose/linux-firmware-work
  git -C ../openembedded-core format-patch --stdout -1 \
    origin/master meta/recipes-kernel/linux-firmware | \
   git am --signoff -p4 --directory=recipes-kernel/linux-firmware
 ```
 
-Second we merge the backport branch and fix the license syntax
+Second the license syntax is fixed and the work branch is merged
 ```
- git checkout wrynose/linux-firmware
- git merge --signoff --no-edit -X theirs wrynose/linux-firmware-master
+ git checkout wrynose/linux-firmware-work
  sed -i -e 's/AND /\& /g' -e 's/LicenseRef-//g' */*/*.bb && \
   git commit --signoff -m "linux-firmware: fix license syntax" -a
+ git checkout wrynose/linux-firmware
+ git merge --signoff --no-edit -X theirs wrynose/linux-firmware-work
+ git checkout wrynose/linux-firmware-work
+ git reset --hard HEAD~1
 ```
 
 So see the full diff of last merge:
 ```
-  git diff HEAD~2
+ git diff origin/wrynose/linux-firmware
 ```
 
 Contributing
-- 
2.56.0

