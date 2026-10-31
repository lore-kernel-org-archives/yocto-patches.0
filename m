Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.422.1793465161621422417
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Y52uP90i;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=EWX6Dzzt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGU7ds2633480
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fwGlxKv6PUh
	QSpHylIhB4bFRe006OgF5A5J0/5U76w0=; b=Y52uP90iHvaf27H1TL+QfV05lau
	ZfVNmKTPNpdGazEgaBk9DM0Azcb0gg1OrAiyUiIj1fNmPbU1dwugB/N+MQ/jHmmw
	y+gXPAtxtAtpQya1y/g+nl8HcFx8Kp0oYgrMTat24QsDOn0qZ4MLTxTZEcMSvx5A
	bkS9mqjx15q0+AhR35UR4QS67R3Xan9k3tzwQP6tEQzRxUhdyPO+6bA0zTpiVOsa
	1/t7M24VAAoePB7abeM0rN93wmNgL37jAz/2YeuqiKnQtdhwOe/5G+rGjWTw7ijZ
	pqYXPMIcCianbWG+4az0gRoTluxPwex21joeJRIk9rVBdAN7wiWWOKCDp1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkhxvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so153898785a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465160; x=1794069960; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwGlxKv6PUhQSpHylIhB4bFRe006OgF5A5J0/5U76w0=;
        b=EWX6Dzzt3BPBvrBAUpbnSRo31zYwKyz005CY3efIhp8vcaDzLgRn8G3ySss97EVEs0
         2kjIOwdXg6JfWIL8jnFvgpy0Fhsn7YcbqUn5dXNsGyT0yG4ujxYijJ47psI/A612oRDd
         QOKndjJlzxCZsAzthGS6AN5XdI4szrjGmnZlw3L3Bb5tzKeY35FoxmWXpAfP1DbBDO4b
         tTcNT/v42pj5fAFdFgNRWKWHp5/8hLNB42nubkluPYwlql7AQwxNDspT7nLqUhKDgJxK
         U6sAaEq634NbaG8Sih9nwRMAbXrdqBfj+BCl+fBb7fc8Og9Gxy1zyFydVCmpBiPE+qnh
         XvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465160; x=1794069960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwGlxKv6PUhQSpHylIhB4bFRe006OgF5A5J0/5U76w0=;
        b=bO+ctzrX4TGmA79BCgvc+1mTwrMAi/xU/s17L1twocs1ArRljHwRcBsb/2nVINyqcM
         DqQvGpFtoS6zJjTJEZPmV5swlJiKJ0CWbrsUQKDN362vYXPtWgR18tk8mJkmS1Mb3Jw2
         e9YtMac62nqfAG8Nh3NTC7lQji9KzkE9rqCvlzf58MUjKv51Zto5zbKBB+T1+kP0MxRO
         vkKaZkMbTYYTH0/V2q/AdersV3JsmoFJcUex7qQZfQxIOtowqPc4RFFcpAp/xK8tMdES
         ktdm3QoLV6dM5WkPfvRzkST+KJf4GXTulMnz+6gTfBiPymYk9BnS+HoadjieMjgj9VD5
         tQgw==
X-Gm-Message-State: AFq9FYIC4aX8BIqOy9Cp1cdsw6jPa6PZjv3VyDHGILq8DLq6ns8ffCGd
	lfUwiuhm6psKVUd85Tmpgl0j0zbAbYLSiLILSzGHlos2xLhc//1A9IbeArQkh8fq04kC/hoDMIS
	5zxza+Qif0NrBKkVa1yZqu0AY40ToL4iolmWHDq8Od0nat4rveqjg14ax7O162o0ChTomXR71a5
	biIfW6/iuqXQ==
X-Gm-Gg: AYBFou2IGOJSX4xA+PdIMYhnb5C+rh99+B2BDeS7EFuYpMNd8KfL9IbFFPvjs3gaz22
	XXHElrP4/EtEM4VkDptiTiEWv6+9nEaN0kJA/8l3CUibP01/rXLRrD/uzln2ZWp/c1bbfI1goUQ
	KxNj2jCin8F5Tyywt5WGScE8Dlpgq3y/gz8/T9NMdfzzByvLalBcSjpmm9LAXkbah3EMHixCCyn
	sjHg08249a89sum/rvhTXPUU4WdpjZFif2kH7Y3w5ahRDTfEE3FGPeRlqxU+p9/K5awmPoLF/+L
	PKgxF5bsh3/eyJ35dmHHEP5IRlraMb56OdZLrSSz05Cmjgf9ss4E17sC28ATQ3aXFU4QhUQQd/c
	4/F3bBBvPX2/EsRJAi+Ne4DZRfKUDkCCXxEM/dHf3pKd1ifrMwFwHCbUrs0iSf0U=
X-Received: by 2002:a05:620a:84c4:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-94421713361mr926305785a.45.1793465159667;
        Sat, 31 Oct 2026 09:45:59 -0700 (PDT)
X-Received: by 2002:a05:620a:84c4:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-94421713361mr926303285a.45.1793465159131;
        Sat, 31 Oct 2026 09:45:59 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:45:58 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 06/10] README: ajust formating and add note about fixing license syntax
Date: Sat, 31 Oct 2026 16:45:39 +0000
Message-ID: <20261031164543.1668-6-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hamWWYt71SVtHv7RAmrOw3ghrc79RiGp
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae61b48 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8 a=jaglQURSS2jnMsCvYecA:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX6uYe5zX9VNyN
 dlPkFEaTXlzacYHvyIumn+7e1r58AJTmc3wJJaS/ppkMKwfusSr5WgMLPfqvu4fRl6+AVwAxXI3
 Zgx0qQtQRP1zKZ/6JN/PXVhUr++TONw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX2TxkFz5wINS6
 BFjsrWFrxFDhpc0rYPO3Vobztc4AV6cHGTcsd+QdhKNyo4VoarddVluGpo5VSIVoQ+BfrDI/Bav
 QEeiJa4g7sv4UqxRk81t8IyJjjYzDW84mMi85tTIrcxKcNIB625UmXXRdyji47qtkB+/NGaFVuL
 vycNKwulPMyNm+fW//4pmeCmO4Loi9NrD0hy4WxG8UqZ9rCG+9F+lxpq/c9I1j5awFPtdpe78Go
 7Hh/MtTH/8Cgz/rKKAqbaSGw8vmtB2QFSqnCSMzo4QW5xmtC001VwTwloF5foQClS40B/E+V0i9
 vUrVlH00o+lXsx+I3zBlXMlxSIhMOd8wcFpWUSyFEjy8hgIJ4b90zkLBJE4tZWYglH9ODuOnTO6
 /i0KwQXshiGtajIrhc7x/8kI6euST7i0HsMPx9cqtSdZt7wyi4zZF9+BCgbxKPoao18uI4R606e
 x7+YgZyF5ZOfQbJum1w==
X-Proofpoint-ORIG-GUID: hamWWYt71SVtHv7RAmrOw3ghrc79RiGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5198
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index ef6f019..81eb6bf 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,5 @@
 meta-lts-mixins - wrynose/linux-firmware
-================================
+========================================
 
 "Mixin" layer for adding latest Linux firmware into the Yocto Project LTS.
 
@@ -27,13 +27,27 @@ This layer depends on:
   layers: meta
     branch: wrynose
 
-Contributing
-------------
+Backporting
+-----------
 
 The patches can be backported from openembedded-core with:
 
- git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-kernel/linux-firmware | \
+```
+ git -C ../openembedded-core format-patch --stdout -1 \
+   origin/master meta/recipes-kernel/linux-firmware | \
   git am --signoff -p4 --directory=recipes-kernel/linux-firmware
+```
+
+There are breaking changes in master in the license syntax,
+they can be can fixed with:
+
+```
+ sed -i -e 's/AND /\& /g' -e 's/LicenseRef-//g' */*/*.bb && \
+  git commit -s -m "linux-firmware: fix license syntax" -a
+```
+
+Contributing
+------------
 
   The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
   for questions, comments and patch review. It is subscriber only, so please
@@ -43,7 +57,12 @@ The patches can be backported from openembedded-core with:
   '[meta-lts-mixins][wrynose/linux-firmware]' in the subject.
 
   When sending single patches, please use something like:
-  git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][wrynose/linux-firmware][PATCH'
+
+```
+  git send-email -M origin/wrynose/linux-firmware \
+   --to=yocto-patches@lists.yoctoproject.org \
+   --subject-prefix='meta-lts-mixins][wrynose/linux-firmware][PATCH'
+```
 
 Maintenance
 -----------
-- 
2.56.0

