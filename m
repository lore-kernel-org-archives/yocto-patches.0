Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16676.1793817822661482937
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 10:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=EZrpDcjU;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=RTcK2SAy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FjGqs2829051
	for <yocto-patches@lists.yoctoproject.org>; Wed, 4 Nov 2026 18:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=InBCOL+GKV6EFiO5FGPa4tGiaNFYV1hipH0
	77ro1NPk=; b=EZrpDcjUBa8Sk9AGsbLc2PKvRRsd+1TWc8toch3RviUwppGVDyC
	Sa/6Zdppl5bpWsbPa8feRIEhjHQde2mfvcJYNIDToYVp4yhJtWGvbUjRgJZmFLSV
	VrksztSyiTv/FuwbThHCV4rKCvRVdFafeB32tcfQru3kj/3/kcEZH2HcRHi+1XYH
	Ii3oNRZH6fVjqMxDF42lCoOFRkQUiJ35pedEcvJZoSvb7ZC+yEOK9r90x+Vv7hUi
	7NWPc5daQxLDTUG8sY1Ai5vwwrTQfENmajVWGtjkWP8ujnlgWSYcLoRMg/wIIYPT
	AX3fhJ0CsJD4c/uq1Ez0tDFkRbOMSFvFxsA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284t8p4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 18:43:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so802555a91.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793817817; x=1794422617; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=InBCOL+GKV6EFiO5FGPa4tGiaNFYV1hipH077ro1NPk=;
        b=RTcK2SAyayFdvrTJIjuokLVcsXz3jnQTCAPFYyUwkuuY5d5hLZhtGh4RBCRHcuAOEV
         y2xO8wi35uaGgf4kfBoUzUrvkPoX6uFO7DwVvq5v2El4NDh+9J/B6BHNiqLlFWL8CzeX
         XXynwj4A8R5JBsm0j6QGI5JLQ0jj1L2ABKDUPftP3ZFIQDL/r9vxp6CZN3ozyBocjz7p
         mF+/IjLvfzoNxxycs/JPomzybBaiku1Qaz8eH4rJnQbbp3NTeNM1JXfym2T47q6io3c5
         D1CFP+FjiX8Uf5DYjBJ3go7X339TqKaSajC+6A6AQ44KKyf4ppDIKOoz2HIp1MG4fF18
         O8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817817; x=1794422617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=InBCOL+GKV6EFiO5FGPa4tGiaNFYV1hipH077ro1NPk=;
        b=JRLcixp/JzEpfRfTP5lidThDVTcvXg9QmC5+GvXpkbpd6y1hWqiKQ3nU8ppMaC9vg5
         Dp7BAXKxVGn5SqBFWqy+asXzh3GivW4t4WnqPqOAVTT0HBUth3IDkQWCtFY1D2wrPQQx
         uJsfWXjjk6cGUf5dRw9FD7px3maS5c+5k/4y930FjUtQUCeBeOh6jH0NMIyoPD6rauZV
         nT/Wi9lC70K/MZJoGLXfQmooznxJOXakGYN7RW1LsM4awMdflHvE4m1M0gZdfq4bEdvu
         tNNGJQyYL3R1r4oaWoUI3ISzsMaBIXhHAN/H/Rp0uKYvDq+Hi6XJbZJKDGoBBHJbBIE2
         lMrg==
X-Gm-Message-State: APuU4Z+0RxngiWPD2aWSETOiZUw13Qcz7Gv+i3ur66wuiGdpfRi2TXOm
	JaFlukvIBjX9D0bQgWcHlbCH8QvFhoVRa4yg8HW+N0WMdpTpRt4P7norIlMfFKBIAw4VG97ftP8
	O0ckqWzMSQSGJTNFs67vdllQeOqr6Op563Kb1a31Elh/pjEox+u5aHZ2Sn3cMEG9xwZjCn84gzS
	h0eT8fo9JKPBWA
X-Gm-Gg: AYBFou2B5kbqRX3bXv1g9r5j/NudG08nWNDPhUz9weOXTDxIanhpACT7+0LHhtoc5/W
	76Ip65jcLX+1PqpKE052eAiXetttUyJqtUeAFzcAJCC6NRRnnWA4siewmCwQ29D/OM/XSjPrjFk
	n6PxHRyVBWQJxeS3YJ2gvsifVwtfDVjGe9wbLt4E0TM+VhzyNn8ZYw0QOotes585G/UrKaF5bZK
	wNYyMKuEH3mKcDZ1oh8imQyZl48jh9g4bAH0Kz5xsc/4lWI6FQf7pa/I6J6HqGUH9BoFnCUeRlq
	0tdVXnMKLFjaEypRlA3OjxD8QVMsMUn6XdXCB844CQnhRCxjwOyVQI62Nlk4Tiz6q91QN+bZowQ
	RubLHn8FBifewlVs3O008b2Ii/ZXjri/KdWRcg/v9N9YTwekJlNgWDtruoHP5f1KJkcZeRi0LWG
	+Uoe/05bAgoX6Hy7wuK4DeGPciHqfcbbezx+mRTU/nN2TvGTovIueV7ZxtOqDusCaG74hsTZ+3r
	gsyDy+DVYPvExr4
X-Received: by 2002:a17:90a:d444:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b0afbf756fmr201295a91.3.1793817816851;
        Wed, 04 Nov 2026 10:43:36 -0800 (PST)
X-Received: by 2002:a17:90a:d444:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b0afbf756fmr201286a91.3.1793817816063;
        Wed, 04 Nov 2026 10:43:36 -0800 (PST)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3160634sm188684a91.6.2026.11.04.10.43.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:35 -0800 (PST)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] tpm2-openssl: Fix build with OpenSSL 4.1
Date: Wed,  4 Nov 2026 18:43:29 +0000
Message-ID: <20261104184329.3927007-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb7cdc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=bUQKSiCPAAAA:8 a=SnVqQYeKqNfise1GfHYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=-fHZXUhsFbuwFN3fwQAr:22
X-Proofpoint-ORIG-GUID: moZzl7iWMV8zAf7gJeezUvLbxKfVGi_D
X-Proofpoint-GUID: moZzl7iWMV8zAf7gJeezUvLbxKfVGi_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX3yoy3+Tibe5I
 MmyVvZVXM5lXZTndWdDn7mwnFRjRuT3RB4PAPZqSgYUP2QmWF3v+OsCo0jHYhdBrZaKBRtxkO5k
 kaUtJnR9foR1NrnaqR0QZpyRHa7h4vEYmAlzreTKVfcqLS5hI+G2FBOAaCiMNjEVB3WvT51xRLM
 Z66lY771YwFDrauaFOW3TlGr8k9wxh6dNM4Gzq6SaCrj8azqdSxMgys6QINuLrYzae0ijDQagLd
 o1OnpVahot2rcczr2kLJHKw6OG3hR1ViHwvSPNaQMPRBrOjUcDBRWVxWt4Nt8njqbl2YwUV7DWi
 9xktSQ1wQ1SG4lUehJE3/FizNNZLm0tq3I7P10eQdaAgszcEAySGeJcHRoM8Ty7QEVvD5qHKUMQ
 i6XuELRRYpVDD1Lbywhl1V6y0pTu9c7kZ1cHlDqJNIo76m6v52m0oIfaKct+FUy1hlRkUPk0XNj
 JnBhG9kF7qwKF6BadFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX0sZmbRFxiu/A
 ex0wFZJoMJHC8s+veKwZ/D3uL5kku3czPUQ297zcsyXbhNygYkQ17OqbgOugReTtfWyP+S9AU18
 b36CJ1A9w/rsBOD+P/yW2Y3gr2tYcTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040074
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 18:43:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5236
Content-Type: text/plain; charset="utf-8"

OpenSSL 4.1.0 deprecates ASN1_STRING_set() and ASN1_STRING_length(),
and its pem.h macros now call ERR_raise() without including err.h, so
tpm2-provider-pkey.c fails to build with -Werror:

  src/tpm2-provider-pkey.c:32:1: error: implicit declaration of function 'ERR_raise'
  src/tpm2-provider-pkey.c:84:5: error: 'ASN1_STRING_set' is deprecated: Since OpenSSL 4.1

Backport the upstream fix.

Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 ...key-fix-compilation-with-OpenSSL-4.1.patch | 86 +++++++++++++++++++
 .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch

diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
new file mode 100644
index 0000000..0b482b1
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
@@ -0,0 +1,86 @@
+From 9cc4cbe25702fc95c536dfb6723ae454e0039faf Mon Sep 17 00:00:00 2001
+From: Moritz Buhl <moritz.buhl@infineon.com>
+Date: Tue, 1 Sep 2026 09:58:28 +0200
+Subject: [PATCH] pkey: fix compilation with OpenSSL 4.1
+
+Avoid deprecated OpenSSL functions, add fallback defines for older
+versions:
+src/tpm2-provider-pkey.c:91:5: error: 'ASN1_STRING_set' is deprecated:
+Since OpenSSL 4.1; use ASN1_STRING_set1_data() or ASN1_STRING_set1_string()
+[-Werror,-Wdeprecated-declarations]
+src/tpm2-provider-pkey.c:165:41: error: 'ASN1_STRING_length' is deprecated:
+Since OpenSSL 4.1; use ASN1_STRING_get_length()
+[-Werror,-Wdeprecated-declarations]
+
+Add missing header:
+src/tpm2-provider-pkey.c:32:1: error: call to undeclared function 'ERR_raise';
+ISO C99 and later do not support implicit function declarations
+[-Wimplicit-function-declaration]
+
+Upstream-Status: Backport [https://github.com/tpm2-software/tpm2-openssl/commit/9cc4cbe25702fc95c536dfb6723ae454e0039faf]
+Signed-off-by: Moritz Buhl <moritz.buhl@infineon.com>
+Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
+---
+ src/tpm2-provider-pkey.c | 22 ++++++++++++++++------
+ 1 file changed, 16 insertions(+), 6 deletions(-)
+
+diff --git a/src/tpm2-provider-pkey.c b/src/tpm2-provider-pkey.c
+index 80213af..bb56ba7 100644
+--- a/src/tpm2-provider-pkey.c
++++ b/src/tpm2-provider-pkey.c
+@@ -2,6 +2,8 @@
+ 
+ #include <string.h>
+ 
++#include <openssl/err.h>
++#include <openssl/opensslv.h>
+ #include <openssl/pem.h>
+ #include <openssl/rand.h>
+ 
+@@ -9,6 +11,14 @@
+ 
+ #include "tpm2-provider-pkey.h"
+ 
++#if OPENSSL_VERSION_NUMBER >= 0x40100000
++#define TPM2_ASN1_STRING_get_length(x)		ASN1_STRING_get_length(x)
++#define TPM2_ASN1_STRING_set1_data(s, d, l)	ASN1_STRING_set1_data(s, d, l)
++#else
++#define TPM2_ASN1_STRING_get_length(x)		ASN1_STRING_length(x)
++#define TPM2_ASN1_STRING_set1_data(s, d, l)	ASN1_STRING_set(s, d, l)
++#endif
++
+ typedef struct {
+     ASN1_OBJECT *type;
+     ASN1_BOOLEAN emptyAuth;
+@@ -81,8 +91,8 @@ tpm2_keydata_write(const TPM2_KEYDATA *keydata, BIO *bout, TPM2_PKEY_FORMAT form
+     else
+         ASN1_INTEGER_set_uint64(tpk->parent, TPM2_RH_OWNER);
+ 
+-    ASN1_STRING_set(tpk->privkey, &privbuf[0], privbuf_len);
+-    ASN1_STRING_set(tpk->pubkey, &pubbuf[0], pubbuf_len);
++    TPM2_ASN1_STRING_set1_data(tpk->privkey, &privbuf[0], privbuf_len);
++    TPM2_ASN1_STRING_set1_data(tpk->pubkey, &pubbuf[0], pubbuf_len);
+ 
+     switch (format) {
+     case KEY_FORMAT_PEM:
+@@ -150,13 +160,13 @@ tpm2_keydata_read(BIO *bin, TPM2_KEYDATA *keydata, TPM2_PKEY_FORMAT format)
+         goto error;
+ 
+     if (Tss2_MU_TPM2B_PRIVATE_Unmarshal(ASN1_STRING_get0_data(tpk->privkey),
+-                                        ASN1_STRING_length(tpk->privkey), NULL,
+-                                        &keydata->priv))
++                                        TPM2_ASN1_STRING_get_length(tpk->privkey),
++                                        NULL, &keydata->priv))
+         goto error;
+ 
+     if (Tss2_MU_TPM2B_PUBLIC_Unmarshal(ASN1_STRING_get0_data(tpk->pubkey),
+-                                       ASN1_STRING_length(tpk->pubkey), NULL,
+-                                       &keydata->pub))
++                                       TPM2_ASN1_STRING_get_length(tpk->pubkey),
++                                       NULL, &keydata->pub))
+         goto error;
+ 
+     TSSPRIVKEY_free(tpk);
+-- 
+2.43.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
index 07feb00..fdef883 100644
--- a/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl_1.3.0.bb
@@ -7,6 +7,7 @@ DEPENDS = "autoconf-archive-native tpm2-tss openssl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
            file://0001-Fix-ASN1_OCTET_STRING-and-X509_NAME-access-for-OpenS.patch \
+           file://0002-pkey-fix-compilation-with-OpenSSL-4.1.patch \
            "
 
 SRC_URI[sha256sum] = "9a9aca55d4265ec501bcf9c56d21d6ca18dba902553f21c888fe725b42ea9964"
-- 
2.43.0

