Return-Path: <beroset@ieee.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDDC25B78
	for <webhook@archiver.kernel.org>; Sat, 25 May 2024 20:24:17 +0000 (UTC)
Received: from cordonneriepedica.ca (cordonneriepedica.ca [64.118.86.28])
 by mx.groups.io with SMTP id smtpd.web11.5327.1716668652540728454
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 25 May 2024 13:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@beroset.com header.s=default header.b=lHS/D60M;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks3.google.com}: limit exceeded (domain: ieee.org, ip: 64.118.86.28, mailfrom: beroset@ieee.org)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=beroset.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+yc3uuGslW2TxXBVWWmouopH5B8P8tDjzPXsnLu/zm8=; b=lHS/D60MKvGdR5zyhJ3PEzVIvr
	3+6BfwozPCVmFgdyR/37qgQaBP9wBBjRAbJCS8vuYrzEswsK//UyM0IN1qgTJC65oDU4+/QbOg+Ba
	Ys2vPqZ1Wbnum0crWnhqmmnVQKYL5M1hxp2oIbrt2LZ6BZJtHi6/SPCOe7nFDH5kr7J/a8gC2BRgi
	WaS9US/f9pL2CLFdi04HI0yNjMZgUjKCU0znvcXx2lcemHFFC2G82fEYnX4Dhho+8h9Ii0DnDZZCa
	nIPUN9h5GNjIom8f80h/sCRwPZ8MoXhPwyiHRpzNa7LRBunBHQzkp/klV62Q5qd5TX3c3HeI+iLJg
	+E9R27wA==;
Received: from 104-185-76-86.lightspeed.rlghnc.sbcglobal.net ([104.185.76.86]:52408 helo=flash.attlocal.net)
	by drive300.trustyservers.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <beroset@ieee.org>)
	id 1sAxw6-0000000D6Jy-2v9M;
	Sat, 25 May 2024 16:24:11 -0400
From: beroset@ieee.org
To: yocto-patches@lists.yoctoproject.org
Cc: Ed Beroset <beroset@ieee.org>
Subject: [pseudo] [PATCH] Use raw strings for regex with backslash-char pair
Date: Sat, 25 May 2024 16:24:01 -0400
Message-ID: <20240525202401.1908193-1-beroset@ieee.org>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 25 May 2024 20:24:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/191

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


