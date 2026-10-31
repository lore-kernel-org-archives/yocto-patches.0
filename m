Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.524.1793465160348950706
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:46:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=NiYfHDH/;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=iWMFi/ak;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGUAB43220139
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kG8eEnPbmpZ
	XnAL0SHMw5gcFz45/qbO0+zMHllAsJ9Y=; b=NiYfHDH/Vu75Yjd1WwFHbzV+dXn
	rPfM0y35OYL9ajaMk7CTVuTv3HZ226gCYyPVtUBDD1GzeTR1CIwBTc6BNN1sQDis
	rbYE3pb6GvFbf5Gj1VNzkvtQVTSrfavVZmpiXgQciopET3Jq4oqc3iTqbdMsmTnE
	evld99/1bG4YGcB/PfFkExPjanryBD0KJzOzAXMPtRVQ7x82qOjtWBT8oRzWFCAZ
	3nyTorUg328S61bPb7UpKUREOhjplWGReIhG8O4jXtj8Z3vUQ8mpRh3TmBQQf/SW
	bSpkgbduTwALTaGbHK3JS6gudJNsv5L81Qp2ChWa6CJiZYJPO9kUWqeshcg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7wxhmn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso532676185a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465158; x=1794069958; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kG8eEnPbmpZXnAL0SHMw5gcFz45/qbO0+zMHllAsJ9Y=;
        b=iWMFi/ak2sRDQ8JuOxnQL9d5WHd1L9kzMPZMk+3tNwFrh73VOowU1ug0lrwmLElAjx
         AElGEIZB1sps3GG2l+tNsa/pLkQZsmYRax0MrtRdEWA/E8Mo2Nc9PnKrJ6kOOcZ+qVKb
         v7V0Hkh0NI8W6aqa7Pnm3U3Hc9dNMkc4wMZuEuk9D+5FWXDOYE7B7NmlLxDZqWsMxBjf
         BgkXCKx62w9WqX7qZ6BYml/hgyydX4XV7QLbYJRJmAEwNLnF/2e/ToACTJX/d94evPpP
         5rbjq2/Rn27CggigKe13IeKSvdtxfm4VzsZFhyVeta3fAxBoSallO2HAQf4FYibGvWr4
         pngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465158; x=1794069958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kG8eEnPbmpZXnAL0SHMw5gcFz45/qbO0+zMHllAsJ9Y=;
        b=lztkNz+Z/6dJj5FfHbKTbh4eBuOaZyCogxoj0nqs6T5z64jof1FLxZQFlIWZ6cu6H7
         qkFknp36en8EqRA/FFXj4SFSBLcjym0il2V0KieGmGlgZDBtNHf84OBnNvtVjsSEHNrb
         lP8gpZvdk2tOkQB9lfzrpOxbOgQXW6T2kDsJRZsONUVBrvuga8IPDoHwQTiPYMUxFIJG
         LHD4qfd+A1GBh11URVHZJWFzrRK/HLr0XQCzJ4VEqBRFWdZSAlpHDtZXtXeWrU00nPIn
         0nk+cuJI6AY0hIguZToiuW/dTJJaspZZLcZ8nX3QlStEv2N+Qlp8cs4hZs2GAT70n9gz
         cA+w==
X-Gm-Message-State: AFq9FYJFeXopn9mUimmkIH6zu56RF94IFUswoqZYApH9GpgBG995annu
	Ny6VhPUPqtc4CcsPhYDk10h02G7RgDxwX9BUMiZ92Vp4gfrONZDkaZBpA1tqtON5gZwOvxXkOuQ
	lI3dRtmV8kQy4k688nosmFnr827nFOJDoIM0f2ITKKYoS+HiQZVoUkla8BW5PSoq1Fmdy3A5/Y3
	yG+1UxdjuUbQ==
X-Gm-Gg: AYBFou0cW1FRGSNQ6k4OaB4jD7R0sYn7FfYBD3uS2Fn2lwIx8/+SuVL3phLNwVfmIhy
	enrVR0mYosQrH4rODtCPIVUIPPu8ussEKFHvAN9jn9HxxTNj/kLjoPKdrAFzVeJsyacob+h8FXQ
	MVxtaOAQkec31Qdlm1SA+35ecRsWZk98PCSHN4mOG2+io3DorfEJ56u5iYLXEamPlTMctjWsOUC
	V/RW/2NsXgo/6EK7stL/nBEScn2sYCZxQ8a8Yx2b5Vz77M81hxNp4YnYB3zval3jfS+nwEmlWqi
	l8U2Z/nE8fMKnVNK6sWMrjuRv30A/78s0l7xAt9Sbuut+iVr3mS8cSvQ+mJFMrn4DBd88GBcHP4
	XP78le2MNHcUhjSFSdb6Wbd+J2iUzlND7GBHsGOvJ14lZQyusiou4ekGJK/YWUmw=
X-Received: by 2002:a05:620a:4614:b0:93f:5a85:cf9 with SMTP id af79cd13be357-94413359237mr1387970385a.7.1793465158250;
        Sat, 31 Oct 2026 09:45:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4614:b0:93f:5a85:cf9 with SMTP id af79cd13be357-94413359237mr1387968085a.7.1793465157763;
        Sat, 31 Oct 2026 09:45:57 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:45:56 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 05/10] README: fix the license before the merge
Date: Sat, 31 Oct 2026 16:45:38 +0000
Message-ID: <20261031164543.1668-5-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fob03Hcm3ZImAUwgme82XfVvXIMsDCqp
X-Proofpoint-ORIG-GUID: Fob03Hcm3ZImAUwgme82XfVvXIMsDCqp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX4WyzZcTCcS5A
 OasMXhYGhR+GUM/Zlw6ieJUtpxIGvKTvmDRddne5BZ+sdOnzpX7l73RwH/NAFraM2uLtNalgNdn
 RoXTRzU1Z4Me6liiWv0Tbz8E8fjiGCg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX2Wax8oNRY6Ld
 /3/+AVOpNqL+QxZZltdTZTF58BadaT9t2IDvRTFXVhW6SEgsDRvIcjg7YMS5SyAsbBkd73TE/Rt
 aF/2F4+L8vYEwvR/sKiVK17txBkpWzdJRaZYA0t1Xf36C3GEc4WfFegjuBaiewlZnHWeoJhOS1e
 3Z76dECqccKxRhLaZac8jpTf3e21eSVLUHmUWlKX0ylYEjKHA4rgg+/1UvThNeLPkjkTmcKIy4+
 ap/YGQ3W05Y0uyq7mnD1aAxlanR5JDiY6txuDVkCTYP76lZU4dbAJvGOPDSDbMbkesMd1TF6Rx8
 mwpm2yJYZxCiVUn9gXEIOkdOWuNeJneYUQ4c8X/uUxCvG2VWIYadvCdVCF3FZ2QztL1i41TZqEz
 PXb1EAOMuYrphnLg51Z6Wo4x8tIC3y8ZfChvDB1ueRMm7LyC2OG9UvDheBRpItDzcw+yBy7doQJ
 fIBKjeIzdkAEgos9YXQ==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6ae61b46 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nBzi43ItJ7eSSC7wROcA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5197
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

