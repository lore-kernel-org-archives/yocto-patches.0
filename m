Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E761C25B7A
	for <webhook@archiver.kernel.org>; Sat, 25 May 2024 19:49:37 +0000 (UTC)
Received: from cordonneriepedica.ca (cordonneriepedica.ca [64.118.86.28])
 by mx.groups.io with SMTP id smtpd.web10.4289.1716665116605966581
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 25 May 2024 12:25:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@beroset.com header.s=default header.b=Nl8fRjMV;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks3.google.com}: limit exceeded (domain: ieee.org, ip: 64.118.86.28, mailfrom: beroset@ieee.org)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=beroset.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+yc3uuGslW2TxXBVWWmouopH5B8P8tDjzPXsnLu/zm8=; b=Nl8fRjMVLyoWahX1ItSfFqlgqZ
	IytHUp3z03maSqBJ5u/YlCOkwPdCJUec0h3tM2drjTESxBkoe7KXHXTFvZ8Q9NnxqOLEIZi/Hg0xq
	s4iyFMW5JzXYV4M+Xl4C0N5HhP07pj1zkHEcc0P3T+xyMTSJZ+VC4F2U74hBoGGUKk22c66LBO+vt
	9xpTWqRbkT7AoEbz2PwKSl7EQbxr1TiHRiqevUAOtTXRgDOtpAgEJAuJCHoWYA2qeJDxsGz7KW8me
	CfzIERlB3TDJwRtVWq30XPjtXq4lE9Rt0BgaTbwagjnIk3yOfryG/jDBOXO3AYKlR5Z1Qq+0JMxUh
	77K5WAIg==;
Received: from 104-185-76-86.lightspeed.rlghnc.sbcglobal.net ([104.185.76.86]:57724 helo=flash.attlocal.net)
	by drive300.trustyservers.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <beroset@ieee.org>)
	id 1sAx14-0000000CxmQ-3R9f;
	Sat, 25 May 2024 15:25:15 -0400
From: "Ed Beroset" <beroset@ieee.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Ed Beroset <beroset@ieee.org>
Subject: [pseudo] [PATCH] Use raw strings for regex with backslash-char pair
Date: Sat, 25 May 2024 15:24:30 -0400
Message-ID: <20240525192431.1905223-1-beroset@ieee.org>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - drive300.trustyservers.com
X-AntiAbuse: Original Domain - lists.yoctoproject.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ieee.org
X-Get-Message-Sender-Via: drive300.trustyservers.com: authenticated_id: eddieieee@beroset.com
X-Authenticated-Sender: drive300.trustyservers.com: eddieieee@beroset.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 25 May 2024 19:49:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/190

From: Ed Beroset <beroset@ieee.org>

As per
https://docs.python.org/dev/whatsnew/3.12.html#other-language-changes
this removes some SyntaxWarnings that occurred because of using
backslash-char pairs in regex strings.  This simply changes those
strings to be raw strings instead.

Signed-off-by: Ed Beroset <beroset@ieee.org>
---
 makewrappers | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/makewrappers b/makewrappers
index cf5ad60..1e80e30 100755
--- a/makewrappers
+++ b/makewrappers
@@ -127,7 +127,7 @@ class Argument:
             self.vararg = False
 
         # try for a function pointer
-        match = re.match('(.*)\(\*([a-zA-Z0-9$_]*)\)\((.*)\)', text)
+        match = re.match(r'(.*)\(\*([a-zA-Z0-9$_]*)\)\((.*)\)', text)
         if match:
             self.function_pointer = True
             self.args = match.group(3)
@@ -135,7 +135,7 @@ class Argument:
             self.name = match.group(2).rstrip()
         else:
             # plain declaration
-            match = re.match('(.*[ *])\(?\*?([a-zA-Z0-9$_]*)\)?', text)
+            match = re.match(r'(.*[ *])\(?\*?([a-zA-Z0-9$_]*)\)?', text)
             # there may not be a match, say in the special case
             # where an arg is '...'
             if match:
@@ -237,13 +237,13 @@ class Function:
         self.date = datetime.date.today().year
     
         function, comments = line.split(';')
-        comment = re.search('/\* *(.*) *\*/', comments)
+        comment = re.search(r'/\* *(.*) *\*/', comments)
         if comment:
             self.comments = comment.group(1)
         else:
             self.comments = None
     
-        bits = re.match('([^(]*)\((.*)\)', function)
+        bits = re.match(r'([^(]*)\((.*)\)', function)
         type_and_name = Argument(bits.group(1))
         self.type, self.name = type_and_name.type, type_and_name.name
         # convenient to have this declared here so we can use its .decl later
-- 
2.45.0


