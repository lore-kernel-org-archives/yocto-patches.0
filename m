Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85CCCFA1E
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:00:08 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17742.1762869598877861966
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 05:59:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=aSZoRX9R;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3410f2cc19=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABDPoAF1946358;
	Tue, 11 Nov 2025 13:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=k3M5QSYvrBCW/nt7JysBZ/NhXNYBZrrHkXYed1McEKI=; b=aSZoRX9R5LBh
	544c2CijANThcXOvy4aGIa8GJQ02QwIKHusldXBQBq92riSGD7dgspLtRF3I7ZQn
	MpKPtnMzIRTsUSFxZruhgTG3w66o78T0pIo6u2eWAKMalnmDyV/M7ka0BS7sGkti
	fN5OZrpHW/oNn3GAfG9I/VkAyqbbHxMUNy8ihc5q7VLFV81ZxVz96KsDkFLWlgfB
	btUnU5lAd1jO+N3wMjRpNVKU6I9x9mHikmhIC51/VLiMw/EWa4xm3Or1RQ4h2agb
	1HGFrTJX3IeNezD93v/0BZ3oopq3FH6fIMhG19Z5xfKwKgRn7XH5WykPfNG///v6
	Zuu6GL/ikw==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9u2x3dce-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 13:59:55 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 11 Nov 2025 05:59:54 -0800
Received: from pek-hjia-d2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 11 Nov 2025 05:59:53 -0800
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>,
        <richard.purdie@linuxfoundation.org>, <mark.hatle@amd.com>
Subject: [pseudo][PATCH 2/2] pseudo_db: fix duplicated xattr in rename
Date: Tue, 11 Nov 2025 21:59:51 +0800
Message-ID: <20251111135951.2121065-2-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111135951.2121065-1-hongxu.jia@windriver.com>
References: <20251111135951.2121065-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMiBTYWx0ZWRfXzK3wN3ObnNKy
 0ZGwUzk78hOxUu/GtvSS+CG5yGOGp/1T2xbCHG80wI20caWphs5UK9LGBdnmq12mblQxsf0Eu7z
 Tx2ep0y5BGaJUiCV9pTT3BB8cuo2lNk2rJIcrWnsu9WtDQ65E/m5O4FoM9uzf+d5p98XjK7jdSd
 /VdQ6JBPwAvOTNIegn2JM7UjV+KsHab8CqE2mC8OK/mL6F4cdYiyeO9J+RAKvYvJ7EponQvRw9B
 8nyZ+jZqyw64yv6570Eg7JSOlVJargVuabq3bnIuPDFAyxpBeDCBnQHscNHPEdp6IMpU+QzKJdO
 uvv7mlU0eA9+rEv2uZ5zLWYPmoHVmOYC8OjUtbgghVuH4KSqOKeoAzaoKRJONb/T9IasI1qDiYQ
 ruZk1KDBTgOEC/oUYyFQkc/4dJX4iA==
X-Proofpoint-GUID: ZqIBiZjQqklKlgZJSdmhpFmIez_MnKcb
X-Authority-Analysis: v=2.4 cv=Uvpu9uwB c=1 sm=1 tr=0 ts=6913415b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=7lCOb9SkZlp5FNohzPkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ZqIBiZjQqklKlgZJSdmhpFmIez_MnKcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110112
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 14:00:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2483

In commit [fbaffe9 Handle rename(3) across devices.], it defines function
pdb_update_inode to change dev/inode for a given path -- used only by
RENAME for now.

In commit [58e4171 xattr work: handle deletes and renames], in function
pdb_update_inode, it defines oldmsg to test the existence of msg->path.
If yes, copy xattrs from oldmsg to msg. If both of oldmsg and msg have
the same dev/inode, it caused duplicated xattrs in the given path.
Here are the reproducible steps:

1) Create a file in rootfs
mkdir -p rootfs; touch rootfs/file

2) Use IMA/EVM signing utility to set xattr
evmctl ima_sign --hashalgo sha256 --key path-to/ima_keys/x509_ima.key --pass=xxx ./rootfs/file

3) List xattr, get security.ima
$ getfattr -d -m ^ -R -- rootfs/
- rootfs/
|# file: rootfs//file
security.ima=0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyBxm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4CAzrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN/YZg4AMgw==

4) Rename
$ mv rootfs/file rootfs/rename_file

5) List xattr, found duplicated security.ima
$ getfattr -d -m ^ -R -- rootfs/
- rootfs/
|# file: rootfs//rename_file
security.ima=0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyBxm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4CAzrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN/YZg4AMgw==
security.ima=0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyBxm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4CAzrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN/YZg4AMgw==

This commit:

- Due to oldmsg is static variable, clean up the memory of oldmsg
  to avoid dirty data from last call.

- Other than copy the whole msg to oldmsg, only copy path and
  pathlen from msg to oldmsg, use function pdb_find_file_path
  to fill oldmsg->dev and oldmsg->ino if it existed

- Copy xattr only if the existed oldmsg have different dev/inode
  with msg to avoid duplicated xattr for the same dev/indoe

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 pseudo_db.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/pseudo_db.c b/pseudo_db.c
index 8b23938..d6ae1d3 100644
--- a/pseudo_db.c
+++ b/pseudo_db.c
@@ -2188,10 +2188,13 @@ pdb_update_inode(pseudo_msg_t *msg) {
 		pseudo_diag("Can't update the inode of a file without its path.\n");
 		return 1;
 	}
-	memcpy(oldmsg, msg, sizeof(*msg) + msg->pathlen);
+	memset(oldmsg, 0, sizeof(*msg) + pseudo_path_max());
+	/* Copy path and pathlen from msg to oldmsg */
+	memcpy(oldmsg->path, msg->path, msg->pathlen);
+	oldmsg->pathlen = msg->pathlen;
 	found_existing = !pdb_find_file_path(oldmsg);
-	if (found_existing) {
-		/* we have an existing file entry */
+	if (found_existing && (msg->dev!=oldmsg->dev || msg->ino!=oldmsg->ino)) {
+		/* we have an existing file entry with different dev/inode */
 		pdb_copy_xattrs(oldmsg, msg);
 	}
 	sqlite3_bind_int(update, 1, msg->dev);
-- 
2.34.1


