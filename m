Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96CCD4855
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 08:34:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70676.1778574841816506194
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 01:34:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=EjErFG8y;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95920cb9e7=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C55agm3447047;
	Tue, 12 May 2026 08:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Llp3c3dtv
	kFVZvK1T3UBnXLCZC6b4wPklbl9ctasfAU=; b=EjErFG8yTcWZ8mImztFNluJG3
	JPvwRaNUu4aZSrv5dssVP1zaFxOIsQDqEBUrmH2sTz1E/L+1W23WhJmK7NSO1OIr
	hK8ll4AU5poIvWjg5FxYVLnTcoDDrghNBnGRrmG5ltHoRtr3Q7XsIr0w70erfe38
	T/0Uwe7k7vSU+YGgfY7oa3eHnFRbc10fOqVNTBmtNjQtURFWMeiBcCNt3bSMFEIY
	p8aKJABnw9VAw/jiPRI9zgA2qyqf1aBfhdl93mKZho5gshI8m1BmOv4Ey6PWobvJ
	ST/HOXhM7eocf7HGsZn8J27GumS9iftFlW6xuKe4FVALA54L/hZ4F+FZREnBA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e3nvhrmtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 May 2026 08:34:00 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 12 May 2026 01:33:59 -0700
Received: from pek-cli10-d2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 12 May 2026 01:33:58 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <paul@pbarker.dev>
Subject: [pseudo][PATCH] renameat2/renameat: only ignore when both old and new path are not in PSEUDO_INCLUDE_PATHS
Date: Tue, 12 May 2026 16:33:57 +0800
Message-ID: <20260512083357.3496209-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L23-ZtJGo-c6S_i6_fcQ_Wv8ljV0lGJx
X-Proofpoint-ORIG-GUID: L23-ZtJGo-c6S_i6_fcQ_Wv8ljV0lGJx
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=6a02e5f8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=xBSEZNHo6avsgon7:21 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=WqNxdtbvE3BMgSs0VGQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4NSBTYWx0ZWRfX2WdQx75LJRrW
 wMa9etmhrFqzHPqyiPYQi9UcHr1L8Sagr62F2EbTPXlj0cmxa15EuqLPTMt6LUX0VkrUolurXK7
 yqVL5J0b/OLH+bQEyfSg1DcMrdm3ronSp2VlcYzpoamoPlG1pgWiRycrtNagEL3ch4JNdCeQ4mm
 L0boj1JwQVBWYVhjp1xED54uMqyOWtaxvSHfSmSppeRKWtELj7VbfX/jZjpq1MEiTWclxh2GbNd
 ZmyMkA8qDQwRW5Vyrwon7l1yOfFsh/mzaL3Wx8dsxkC0TzefGcn37jN5eNaNUhZ3Ti23l2WOrWH
 a5zKpVRALFrLI29vOZjavOevvWaNDnkwubR/ehHR8lJh9DGeJ9DDzFDmbn9Yn2FuEGs/xXk2xLn
 Hd7mCFiTkq+rqEUIVuk2Hihko7pspOYnefGGM9b/Gf8UU8mqkzR2ayeBXZajcaPMS+CcTF9hY0I
 YP6nxNyAsmX/uQt1KTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120085
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 08:34:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3974

From: Changqing Li <changqing.li@windriver.com>

The patch is for fixing failure in the following scenario:
[snip of recipe]
    do_install() {
        mv ${B}/hello.txt ${D}/hello.txt
        ln ${D}/hello.txt ${D}/hello2.txt
    }
    FILES:${PN} += "/hello2.txt /hello.txt"
[snip of recipe]

do_package will failed with pseudo abort error.

Root Cause:
For command mv, when oldpath is not in PSEUDO_INCLUDE_PATHS, the renameat2
will skip the wrapper and call real renameat2, and no entry is inserted
in files.db. Then command ln, insert an entry for hello2.txt in
files.db, which with the same inode with hello.txt. During do_package
stage, when stat for hello.txt, it will find a path mismatch failure
like:
path mismatch [2 links]: ino 190860603 db 'hello2.txt' req 'hello.txt'

Fixed by:
For renameat2/renameat, change to only ignore wraper call when both old
and new path are not in PSEUDO_INCLUDE_PATHS. In guts/renameat.c, when
oldpath is not in PSEUDO_INCLUDE_PATHS and has no existing db entry,
OP_LINK on oldpath is silently dropped by pseudo_client_op, making the
subsequent OP_RENAME a no-op in files.db, so change renameat to create
the entry directly at newpath via OP_LINK when oldpath is ignored,
skipping the pointless LINK+RENAME sequence for oldpath

Helped-by: Paul Barker <paul@pbarker.dev>
Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 makewrappers               |  4 +++-
 ports/unix/guts/renameat.c | 32 +++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/makewrappers b/makewrappers
index df405fc..83f5ca6 100755
--- a/makewrappers
+++ b/makewrappers
@@ -430,7 +430,9 @@ class Function:
             return "0"
 
         mainpath = None
-        if "oldpath" in self.paths_to_munge:
+        if "oldpath" in self.paths_to_munge and "newpath" in self.paths_to_munge:
+            return "(pseudo_client_ignore_path(oldpath) && pseudo_client_ignore_path(newpath))"
+        elif "oldpath" in self.paths_to_munge:
             mainpath = "oldpath"
         elif "newpath" in self.paths_to_munge:
             mainpath = "newpath"
diff --git a/ports/unix/guts/renameat.c b/ports/unix/guts/renameat.c
index 5ac63f9..69130c6 100644
--- a/ports/unix/guts/renameat.c
+++ b/ports/unix/guts/renameat.c
@@ -113,14 +113,32 @@
 				oldbuf.st_ino = newbuf.st_ino;
 			}
 		}
-		pseudo_debug(PDBGF_OP, "creating new '%s' [%llu] to rename\n",
-			oldpath, (unsigned long long) oldbuf.st_ino);
-		pseudo_client_op(OP_LINK, 0, -1, olddirfd, oldpath, &oldbuf);
+		if (pseudo_client_ignore_path(oldpath)) {
+			/* oldpath is ignored (not in INCLUDE_PATHS), so
+			 * OP_LINK on it would be silently dropped and the
+			 * subsequent OP_RENAME would be a no-op. Instead,
+			 * create the entry directly at newpath.
+			 * OP_LINK does not override uid/gid with pseudo_fuid/
+			 * pseudo_fgid (unlike OP_CREAT), so set them explicitly
+			 * to avoid recording the host user's real ids.
+			 */
+			oldbuf.st_uid = pseudo_fuid;
+			oldbuf.st_gid = pseudo_fgid;
+			pseudo_debug(PDBGF_OP, "creating new '%s' [%llu] directly at newpath (oldpath ignored)\n",
+				newpath, (unsigned long long) oldbuf.st_ino);
+			pseudo_client_op(OP_LINK, 0, -1, newdirfd, newpath, &oldbuf);
+		} else {
+			pseudo_debug(PDBGF_OP, "creating new '%s' [%llu] to rename\n",
+				oldpath, (unsigned long long) oldbuf.st_ino);
+			pseudo_client_op(OP_LINK, 0, -1, olddirfd, oldpath, &oldbuf);
+			pseudo_client_op(OP_RENAME, 0, olddirfd, newdirfd, newpath, &oldbuf, oldpath);
+		}
+	} else {
+		/* special case: use 'fd' for olddirfd, because
+		 * we know it has no other meaning for RENAME
+		 */
+		pseudo_client_op(OP_RENAME, 0, olddirfd, newdirfd, newpath, &oldbuf, oldpath);
 	}
-	/* special case: use 'fd' for olddirfd, because
-	 * we know it has no other meaning for RENAME
-	 */
-	pseudo_client_op(OP_RENAME, 0, olddirfd, newdirfd, newpath, &oldbuf, oldpath);
 
 	errno = save_errno;
 /*	return rc;
-- 
2.34.1


