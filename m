Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFA9C5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 16:30:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34898.1786984252266320613
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Aug 2026 09:30:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=NBrNCyou;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oss.qualcomm.com header.s=google header.b=X0hc58lB;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYt6p1840290
	for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Aug 2026 16:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6MYEq6EKZo2hoSbn+SDWmW
	WW/F98x2bRXmn+2uO4vL4=; b=NBrNCyouulmyq67/qGF44pV/x7qfUDazxukuSE
	SAn9yBH0mwce1tcYzW+kCH5C4WQpXpnlW23tlLbLHcdBF5xZ8L19Ap/e93J7ZPxi
	iWu/VaaFOZ1IHauYmuFGkp28EnU/ZpLbcdtqJc6EE6nf5ZaJH8chAhoi+YB4LuOx
	i5FN3JKjRZIk43Htulu7bGpqxhbr8S91RlO3gLti9EUAYCUO5WwlctXCshWCFDuz
	bNS2u5VBkCuhD75id0iVDMMFGmOQa/npgyhMH1hwoo5r5O/HtzdgbyvlL7dk6zh3
	Mik/VvlA9qXQbSsMQ8QCA1yx3kcKSSctQ1vDY9CC9Z8PLlJQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3x30j300-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Aug 2026 16:30:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbef1d25500so3806802a12.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Aug 2026 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786984251; x=1787589051; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MYEq6EKZo2hoSbn+SDWmWWW/F98x2bRXmn+2uO4vL4=;
        b=X0hc58lBu3ucd4s/Tw/BSqozzhSeW/5kQhnYxoe/yUbdxgIEOAF3ZptdAUZWCwDB+h
         9kuffRYO3A+iAJTbNGLi7sbRkFB8cL401ZB7Qddli8z4+kjFjM0BljQud75Pbti3sC1l
         FEWOVnMYJnkcstxaY3v2/7WiYrwVYQUS58lJiLB9+I+ZoNzGt3mNxmPlViAixDXabSD/
         fhW017YGSaFPvJ1SQSKx4Tt9NsOU4wig1yBltfdnPd0DCDStftf28WvTkf19k8ZAdibf
         zM7v4eXDwmpI5MpTF4RoYWKt7iQNlUuYOynyy+Rx9arm1uAyYKMOPUZw+lXDJHIh0aoH
         hvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984251; x=1787589051;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6MYEq6EKZo2hoSbn+SDWmWWW/F98x2bRXmn+2uO4vL4=;
        b=pATNJmmA5moH0OSHEj2QSUim2qLmitLMTFwJa4WH/qZIOaYlYFCiW3Kzjpq17rAya8
         hn+kF2KIsLRHoAUOSa51+TzHCM2VCwmEVHnZNtIxto151h24zpKbUwCouzhW4auhBACB
         DnqOCTHWwDHTIE+c8TRz7C/DIySRTijGzTNiK77LSqX7fMHuRQPCqToT+DPW/u2K2wY2
         Ge86SHOiJySy7FxnVrOJ7RIECNUWdgo/XU+AFbp5AVvpykmQvKGXl4Se6PIRJb3JvbX7
         spXnG6klJ+hMzYJZScDhdD4S8hyPtb3+EMBLHe9Xu4A1FHMG6dtunUDM8EEaUArecoee
         J9bw==
X-Gm-Message-State: AOJu0YwBKoy9eLC+M0ckJ3ou74fQzXowLTABNLeFDHeHu8+8CZyx1P2Q
	RGzAXXHbnryUBjUips3U11mgydtdt9YRkp4IHBAVjg5vYcHlarbO4Gdif0Dtes/GxuP5QSKtmMq
	XsNSLuK7qUM4GkzVxC2jGk9P63c+LTSNEf+MZts9A7QoChWPgN+HPPSJ5EaWf6NcKznC5Xine25
	vsIYqgIDOS3dYh
X-Gm-Gg: AR+sD11FXeHsuHdeaNpoysggSZSdfW8H6KC1FGTwwAW6MqPZwMym66ZFyWHO+szNDJq
	AKfCUx9SIIjBi/1hmsk7LZypyrJ7IwN1zIHOIfnNo11q3hBdIUzsvovbNfxwkhcyD2apLoNyr3e
	fd9Z4HhS6jAMdjD1TA4fXhLkNQrjQ09Q25ByFZ7r8wzk0ikxzdUa9SAMf/j9gvLce2ljDTcVjMb
	QrKYVfZkml/El4V82NRFffFGRgil+fMWNWjvk0ncGZGGCvreQB6KbeSEbfz6IWfi/2MMQaJorfr
	15B5sDJRoH9XP5HMD/muNxdQAcsfTZ2px2n999+C142A1NvWF1qi5z16K/E40VR4kzQQDu0ttJu
	xHW+m35+ID3BG+2yPuFsigTvm8sbKoDifFq2yvf/n4M+RfOm5AdmeTFu43YbYqQdqB1BvPvDIiI
	xMX1w1BP/5FBr0mBGQoehz9+C9lod+imvbNZYIXQU=
X-Received: by 2002:a05:6a00:8d1:b0:847:926a:7ae3 with SMTP id d2e1a72fcca58-84fde21fb88mr24260164b3a.20.1786984250457;
        Mon, 17 Aug 2026 09:30:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d1:b0:847:926a:7ae3 with SMTP id d2e1a72fcca58-84fde21fb88mr24260105b3a.20.1786984249780;
        Mon, 17 Aug 2026 09:30:49 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c03df83sm1044630a12.30.2026.08.17.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:30:49 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joe MacDonald <joe.macdonald@siemens.com>, Yi Zhao <yi.zhao@windriver.com>
Subject: [meta-selinux][PATCH] libselinux-python: fix the build against swig 4.5.0
Date: Mon, 17 Aug 2026 16:30:25 +0000
Message-ID: <20260817163027.2274986-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyNiBTYWx0ZWRfX5P76VLWbBwr6
 8LF6YVyOEPCulcQoCg5v7ObEVP24aBt3Xw5L0SO2cZe6hD5/qTrLukgjXonMyT+rtMET2ZqyXCf
 cIQ4gm7VLKLAyxt9oRNeZD68uliRk1HGSCA6+u4TrqMr9v46XuzCPejLTN4RIcJsRbxjX/g8Ys/
 gnYdUtJK8+O3AoBJ/K6vPQFGA0glP/gOfJ1aoZz653ciYxzYtTefQVzX123aQ6JAPwD0xWVJkJM
 xgsvI8+fJKGkXiLkuKfnwzjNyTJAUip1zWNqk8V0QAFn0YlkCotxdovPlloCFHNtD671kJ0eU2y
 +usA2TSc+NWVaKy5tbmOA+o92dDzgXqITSZ/atp1FN2KxVCXEAp59D4fCoALTeYsdreujcrB4BY
 k0gfC/EE4BWSN2eBDHnNjirKyOrVIc54C54xwk2AYTHmieiGkkCNXU52lx86biqUDG2pg7jBZ5B
 4+BhOA7hvQX8b5hekLQ==
X-Proofpoint-GUID: ETL9hK2gzm_pBsrLvvZyQYI2xm3dODnr
X-Proofpoint-ORIG-GUID: ETL9hK2gzm_pBsrLvvZyQYI2xm3dODnr
X-Authority-Analysis: v=2.4 cv=Y9/IdBeN c=1 sm=1 tr=0 ts=6a83373b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=CMOk2Q9BB4z7hfc2Hh4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyNiBTYWx0ZWRfX91pppFSaoQY0
 l8pN5A29IHFKEo6hh2Y/7Gogad7S1d0phKXW9e73qhiilcHMIqascl9z7BzNp9r/w7hUSGrHhFC
 Xtoxh656jASFoCNRylqGE/GmO2tDqow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170126
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 67HFYt6p1840290
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Aug 2026 16:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4669

swig 4.5.0 removed the Python 2 C API compatibility macros from its
pyhead.swg runtime header, and libselinux 3.10 still calls
PyString_FromString() from selinuxswig_python.i, so the generated
wrapper no longer compiles:

  selinuxswig_python_wrap.c:11583:34: error: passing argument 3 of
  'PyList_SetItem' makes pointer from integer without a cast

Backport the upstream fix, which switches the three call sites to
PyUnicode_FromString().

Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 .../selinux/libselinux-python_3.10.bb         |  1 +
 ...e-PyString_FromString-with-PyUnicode.patch | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 recipes-security/selinux/libselinux/0004-libselinux-R=
eplace-PyString_FromString-with-PyUnicode.patch

diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes=
-security/selinux/libselinux-python_3.10.bb
index 139e6df..e0fcb4b 100644
--- a/recipes-security/selinux/libselinux-python_3.10.bb
+++ b/recipes-security/selinux/libselinux-python_3.10.bb
@@ -15,6 +15,7 @@ SRC_URI +=3D "\
         file://0001-Makefile-fix-python-modules-install-path-for-multili=
.patch;patchdir=3D.. \
         file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam=
.patch;patchdir=3D.. \
         file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona=
.patch;patchdir=3D.. \
+        file://0004-libselinux-Replace-PyString_FromString-with-PyUnicod=
e.patch;patchdir=3D.. \
         "
=20
 S =3D "${UNPACKDIR}/${BP}/libselinux"
diff --git a/recipes-security/selinux/libselinux/0004-libselinux-Replace-=
PyString_FromString-with-PyUnicode.patch b/recipes-security/selinux/libse=
linux/0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch
new file mode 100644
index 0000000..0ec2fea
--- /dev/null
+++ b/recipes-security/selinux/libselinux/0004-libselinux-Replace-PyStrin=
g_FromString-with-PyUnicode.patch
@@ -0,0 +1,52 @@
+From fb518ff492cd6a286f35b415cbd7fd0f6e3faedb Mon Sep 17 00:00:00 2001
+From: Petr Lautrbach <lautrbach@redhat.com>
+Date: Thu, 6 Aug 2026 16:30:44 +0200
+Subject: [PATCH] libselinux: Replace PyString_FromString with
+ PyUnicode_FromString for SWIG 4.5.0 compatibility
+
+SWIG 4.5.0 removed Python 2 C API compatibility macros (PyInt_*,
+PyString_*, SWIG_Python_str_*) from its runtime header pyhead.swg.
+These macros previously mapped deprecated Python 2 C API names to their
+Python 3 equivalents.
+
+Fixes: https://github.com/SELinuxProject/selinux/issues/538
+Authored-by: Jitka Plesn=C3=ADkov=C3=A1 <jplesnik@redhat.com>
+Upstream-Status: Backport [https://github.com/SELinuxProject/selinux/com=
mit/fb518ff492cd6a286f35b415cbd7fd0f6e3faedb]
+
+Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
+Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
+---
+ libselinux/src/selinuxswig_python.i | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinu=
xswig_python.i
+index c8c08a407..74d923e42 100644
+--- a/libselinux/src/selinuxswig_python.i
++++ b/libselinux/src/selinuxswig_python.i
+@@ -69,7 +69,7 @@ def install(src, dest):
+ 	PyObject* list =3D PyList_New(*$2);
+ 	int i;
+ 	for (i =3D 0; i < *$2; i++) {
+-		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
++		PyList_SetItem(list, i, PyUnicode_FromString((*$1)[i]));
+ 	}
+ 	$result =3D SWIG_AppendOutput($result, list);
+ }
+@@ -123,7 +123,7 @@ def install(src, dest):
+ 			len++;
+ 		plist =3D PyList_New(len);
+ 		for (i =3D 0; i < len; i++) {
+-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
++			PyList_SetItem(plist, i, PyUnicode_FromString((*$1)[i]));
+ 		}
+ 	} else {
+ 		plist =3D PyList_New(0);
+@@ -140,7 +140,7 @@ def install(src, dest):
+ 	if (*$1) {
+ 		plist =3D PyList_New(result);
+ 		for (i =3D 0; i < result; i++) {
+-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
++			PyList_SetItem(plist, i, PyUnicode_FromString((*$1)[i]));
+ 		}
+ 	} else {
+ 		plist =3D PyList_New(0);
--=20
2.43.0


