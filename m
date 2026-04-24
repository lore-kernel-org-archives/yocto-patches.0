Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74F6FED3DD
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 15:04:49 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24465.1777043086817985648
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 08:04:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=cq1anopQ;
 spf=pass (domain: axis.com, ip: 40.107.159.18, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2Xb4rD0hb7CW4ANsvD4gDIBk9kC4PHt2r6YiV/ugwZqdARCFBielPEjh28O/gejT3kz0oxG/UnCsvUxZ6jMY0L+bmAIUAvbO+LlwP2YgMjGXIXohkdWf6XTmetjDEqdD1kndQnUrv3LGNrzdtaAFoofgYJ+8nBjSEs7R+yh/phAoF7JeOOM1FGoa8xU5T4uRI/OzrMZNMHRRyqUFAm0XpMZn387CD8ITUV2//qRHDM8xvdAXq6EgvhgKv7IdKh6149iaV6LkCq7ngTsg4sE0LOEeZXuGPaMa/9tGnNz449JHBWD5iKjDZxTQP3B5cuMynQef5Y3gNqDLtbVbx+nwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yXnNgpOCnSwwpwapOitkhZaEhE7+heZA5bd1o+a/5s=;
 b=l3H+watwPO2lYBi7xFUsB0ZD/PhJx4TnHJkJI8yzus9gRhPwpnSHm0qC3EOHNPstQMXrVgcIpstbRaSKtfsg1cMqF9E7fR1smv8nKNbKHw1bmXjRpY7P60paqhmzkQ10ot9D7mnLzFL7dYS63nnrNxqaNPP2UWhERMv646URO1AtsuKQOe5Rz//v16Z+I5qpeyOnH4bf2V+Hksy6lO6b6tcez9m+Q+COA7H9hi2E+m7O9+tQWsOV7+aYNy8dD9svX5W7o6+gu/HOpM9RPKirg6vT+yCDq5E7ulLM2UU9bQWaEttalxGcdMdp+kK6qSQBriBlPuuWojNNOUFMeMykjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yXnNgpOCnSwwpwapOitkhZaEhE7+heZA5bd1o+a/5s=;
 b=cq1anopQgmWLjuhrdTmjbq+JcKQZ4KSvc60mtU832vluI8h+J1r4nnX7lvEYkuZE5u2NLMPZsXRNT/xvD1Q7twx70797CA8UDl++VunQCLpqKF75w3jB3beZ8/++x+bHLdghDFUTBVuPxdqkFK7RBsjIZsmLuEIjUBgmdSDXm2U=
Received: from AS4P250CA0026.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::14)
 by GV1PR02MB10759.eurprd02.prod.outlook.com (2603:10a6:150:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 15:04:40 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::71) by AS4P250CA0026.outlook.office365.com
 (2603:10a6:20b:5e3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 15:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 15:04:40 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 24 Apr
 2026 17:04:39 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 24 Apr 2026 17:04:39 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id C9A6B2FE9
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 17:04:39 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id C03A91205C2; Fri, 24 Apr 2026 17:04:39 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH] linkat: Avoid a segmentation fault
Date: Fri, 24 Apr 2026 17:04:31 +0200
Message-ID: <20260424150431.101072-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|GV1PR02MB10759:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3cbb42-ed82-4798-1ced-08dea212cf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	QF2WEmiAihpqcQJwG0xT36d4gtY5bQu8UiYpHH1QjkKaP2rhDLDOqLzEQnumykf/SGYwP8YLSoDMmwa4qfqN5HSdZ2aMNHcGq8jP0ql0HT8LsZbDa9tFqXO4bewI/17A2tj8toV9pLAxDc4H49AI9qoTGNaMEOo2xeHguKddAgH+/nCBwr2lmAb2pzIv0Iy2WeBhMCFd61U5R7CzQNTKaEkwu2hRmXDBbG2jCt+6MmaKkkyvI+yg+Vqk5MjuK7vV7r08EItxORKCmdDQinIzc3NkMlz1hl99gpq1VjmM+ZbL9Ay6Wqm96tL2RjyfiPVN/GkQ9Qm+fQEWFyD0ndJ2a4zjxiz2s7OhqjcXkKFvXL7oBfMHNet9rhVdbgYlED32Chkei+qxh8ZhZ63J5Ra7EuFFfbu6X0pY8/dx/NHNT7Hy+f09sFNmE3yMCItCu1vgKjSYkeubDS+JJthgJxo2zpkZRGN/7WJ9s/nAptlSNc5syYM/p8wBN3gANVenWrNQ6B/3tyLW2mWHGXDM9Xv1Vl+7FF+mFbdFiLeaML7rEAlfvQF78QZfcfOCOzgpoY20bxKFmqUDRRTjCdrjRW/Chse9N6gpL87n81sM9jCQohcMl5e8zgQLwv/AstFiwETXGw4pBOUjnCTSHnaUK87B6ErjAVCcXD1C5/aocVv6TPh6RbJygOaVd2SoB+JR/SVXx9zoIYJ/gIrK0KtwmMkLoHF4uqlovprtRuOvZ8hx/zNsi4Sz8hIqpvSijhAyJykr6z+0+WROKF2U7gFAdx2RWA==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oiqb+9+w2IugMFnc480XZeAbvHrwpuyIKg5seFQthAXGJqHm7kzSnrQ754fegL1DJyKEL1OQzlL3ujHogRqGvYZz7za53cG3wKFFbvcHEaWT91GYCCeLVw3LTYPHVAHrwN8iOuD20r8hNH8LhYpxSuPrBVVt29hjW7TOQZMfHrnqGPZyOHsudSAK4Z5d0DLepgoSbgfdJJUhUKFIKO7TDZ3WtlOrOlgwYPsswqs4UAHjF7Vj+SSBtP4qNrsxIwdo42l0/0th2pcjQVDafgVyyI1yAcNq3FTMTPNn4+jLyWSTBzEv9wrNcKzkOn94+wO6jbMOuXezx3l782QjPxA2yq9U+rYCZDeu6tyUnQ5uqWNmlH0lnYb24VSHDU86q1MKsFyKflFdEWyo8MtwwJoCwykUuj01s23JtIz/boqjixgU+EpsLUIOL7yFGokjugiX
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 15:04:40.2334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3cbb42-ed82-4798-1ced-08dea212cf36
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10759
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 15:04:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3803

This avoids the following segmentation fault (in useradd):

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x0000795b22562f49 in wrap_linkat (olddirfd=3Dolddirfd@entry=3D-100,
      oldname=3Doldname@entry=3D0x6016835f1fb0 "/etc/group.3167327",
      newdirfd=3Dnewdirfd@entry=3D-100,
      newname=3Dnewname@entry=3D0x6016835f1fd0 "/etc/group.lock",
      flags=3Dflags@entry=3D0) at ports/unix/guts/linkat.c:37
  37              oldpath =3D oldname;
  (gdb) bt
  #0  0x0000795b22562f49 in wrap_linkat (olddirfd=3Dolddirfd@entry=3D-100,
      oldname=3Doldname@entry=3D0x6016835f1fb0 "/etc/group.3167327",
      newdirfd=3Dnewdirfd@entry=3D-100,
      newname=3Dnewname@entry=3D0x6016835f1fd0 "/etc/group.lock",
      flags=3Dflags@entry=3D0) at ports/unix/guts/linkat.c:37
  #1  0x0000795b2257b95c in wrap_link (newname=3D0x6016835f1fd0 "/etc/group=
.lock",
      oldname=3D0x6016835f1fb0 "/etc/group.3167327") at ports/unix/guts/lin=
k.c:17
  #2  link (oldname=3D0x6016835f1fb0 "/etc/group.3167327",
      newname=3D0x6016835f1fd0 "/etc/group.lock") at pseudo_wrapfuncs.c:896=
8
  #3  0x00006016814d45dd in do_lock_file (file=3Dfile@entry=3D0x6016835f1fb=
0 "/etc/group.3167327",
      lock=3Dlock@entry=3D0x6016835f1fd0 "/etc/group.lock", log=3Dlog@entry=
=3Dtrue)
      at ../../sources/shadow-4.19.4/lib/commonio.c:167
  #4  0x00006016814d4e88 in commonio_lock_nowait (db=3Ddb@entry=3D0x6016814=
df9e0 <group_db>,
      log=3Dlog@entry=3Dtrue) at ../../sources/shadow-4.19.4/lib/commonio.c=
:373
  #5  0x00006016814d4f09 in commonio_lock (db=3Ddb@entry=3D0x6016814df9e0 <=
group_db>)
      at ../../sources/shadow-4.19.4/lib/commonio.c:413
  #6  0x00006016814cfc9a in gr_lock () at ../../sources/shadow-4.19.4/lib/g=
roupio.c:141
  #7  0x00006016814c981f in open_group_files (process_selinux=3Dprocess_sel=
inux@entry=3Dfalse)
      at ../../sources/shadow-4.19.4/src/useradd.c:1797
  #8  0x00006016814cacdc in open_files (process_selinux=3Dprocess_selinux@e=
ntry=3Dfalse)
      at ../../sources/shadow-4.19.4/src/useradd.c:1759
  #9  0x00006016814cc388 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>)
      at ../../sources/shadow-4.19.4/src/useradd.c:2585
  (gdb) l
  32              if (olddirfd !=3D AT_FDCWD || newdirfd !=3D AT_FDCWD) {
  33                      errno =3D ENOSYS;
  34                      return -1;
  35              }
  36      #endif
  37              oldpath =3D oldname;
  38              if (pseudo_chroot_len && strncmp(oldpath, pseudo_chroot, =
pseudo_chroot_len) &&
  39                      oldpath[pseudo_chroot_len] =3D=3D '/') {
  40                      oldpath +=3D pseudo_chroot_len;
  41              }
  (gdb) p oldname
  $1 =3D 0x6016835f1fb0 "/etc/group.3167327"
  (gdb) p oldpath
  $2 =3D 0x6016835f1fb0 "/etc/group.3167327"
  (gdb) p pseudo_chroot_len
  $3 =3D 91

The above code (on line 38) is supposed to check if oldpath is prefixed
by pseudo_chroot, but instead it checks the opposite, and then the check
for the slash on the next line is made outside oldpath if it is shorter
than pseudo_chroot.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 ports/unix/guts/linkat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index e1712a9..60fbf63 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -35,7 +35,7 @@
 	}
 #endif
 	oldpath =3D oldname;
-	if (pseudo_chroot_len && strncmp(oldpath, pseudo_chroot, pseudo_chroot_le=
n) &&
+	if (pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chroot_l=
en) &&
 		oldpath[pseudo_chroot_len] =3D=3D '/') {
 		oldpath +=3D pseudo_chroot_len;
 	}

