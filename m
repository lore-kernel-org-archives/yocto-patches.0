Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0875FC5AD49
	for <webhook@archiver.kernel.org>; Sun,  8 Jun 2025 10:28:28 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.35032.1749378505365263651
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Jun 2025 03:28:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l6Y8Zh3s;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so550263466b.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Jun 2025 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749378503; x=1749983303; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMQpg1qBLPCyHtAyHLZhycJUdAe9y1FTdXJr0zl4t7g=;
        b=l6Y8Zh3s+gFcU4Hx0WeYq5pRDQX4BX/1MNxxRqRbxkAUF9Qoj0WJIB4ECsb48gPxkh
         NWR2ol8KdSjU7U+muhj0N0C/0vHm9uTW7+y3H7lm1YnWCV6L3NfxXJf35g8HXl94C1kQ
         yetbwxFE0Scee5WZeIQy0QSIWSpqMjjT0H2M+ug8Fbc6HlT1PFRonq5COfY59FTv4XTy
         wSiS5rVeJRmscTeiMqwPRGyNvqF1nZHkMM6AoJwO8Aplrl9sAr7wphbOCXXM2RK6Pg+q
         Bju9KbczP3kv0f4/KwCte6B6h+UApKozgJf/UUsJmncaD/2xTfG+pnz5GbWACDnsqYxw
         LLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749378503; x=1749983303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMQpg1qBLPCyHtAyHLZhycJUdAe9y1FTdXJr0zl4t7g=;
        b=VUNInPTGUVaYzw18djh8sbRku9UWtFvJI1ysMslhvj2KsChWjPlRjcHqRqIZe2qXx/
         rjqp3LCYt4gYScu9wBaawAshWGd3NGG7ecnYYO5qMqOG6NBOhQAbworo9nFqycOBuhSP
         WWW9Twrpx93SKuXj+nWChxiLZlKIY9hWnYYxHjcfwXPxfJ0CAlU0LxYR7jHNkP4e6E/C
         5Hf/ALA8QhBz/pqAeBIPtYpLNb79UFGSWCyT+7ivZgd3mO1VhMFZBHoxnSzDF8ClUaNq
         MswVEeRaXGRuMPnaDyalvp8SY8+tQcNqp72uVDDiQklk9KAXmZ7Rozg5q7WuvsFTIM99
         iGIQ==
X-Gm-Message-State: AOJu0YwGKVo6GnTvSqVj7EmkFeuk/hxU8a/gJH2S7Kd+mF/NlX+AqXr+
	Jc2h7H42vNP4/0fwvLmgf4RnYlEGCL60ZPdUUzqWlghrlMc8h896FScI7AIuQkxQ
X-Gm-Gg: ASbGnctZfbHyyNAo3MSClfhhpqGYzv425k6BhT8QnTa+RLx2/B3+RbIDGf69njBY0XB
	2uqtwp8yvKAVHR01UCarCzOClFWKEXhkhquv/45nQpZVDB3KTP9fOWVkD2F5xO+kgxHUjVzs77j
	NpPCIE54PdBtIVvGhjp+9PSwtHHxuZBG5yjEpBq7jOXBHgBynY8ITGWNWaNg28YbftjkwXMyB5s
	ixPEC9PJ+4qvJGepAcREli9+rDkgYNMruCVlhgL/EBLtIYY+GQ4nVuDkEw1cPhLIFr19wLNnGk/
	ua28I4L+4YwoD1ZBZZtx3p7nSllo5yVSY5qnteg7DqeNk8C26Vuw91hNbXEyfqoH3IwgPQ==
X-Google-Smtp-Source: AGHT+IGIET+zeAZERAyj/ddfYjtDcp3mOCjp/OOsTLQN9F6pQ2rIjDv6sUqwBdMjv+i9SGJXXQB57w==
X-Received: by 2002:a17:907:da3:b0:add:f62e:a300 with SMTP id a640c23a62f3a-ade1a9c805amr884179766b.2.1749378502933;
        Sun, 08 Jun 2025 03:28:22 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc379f6sm386135866b.110.2025.06.08.03.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 03:28:21 -0700 (PDT)
Message-ID: <d9f98882-e6f0-4ef0-b733-ee91965fc861@gmail.com>
Date: Sun, 8 Jun 2025 12:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-java][RFC PATCH] recipes-core: Fix download
 url for java package
To: yocto-patches@lists.yoctoproject.org
Cc: Henning Heinold <henning@itconsulting-heinold.de>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Richard Leitner <richard.leitner@skidata.com>,
 linux-amarula@amarulasolutions.com
References: <20250605051442.11141-1-michael@amarulasolutions.com>
 <CAOf5uw=nmwSR=aHrVAW+vhXT7DBcphO+o49rH3wYk5G-W4mP8Q@mail.gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <CAOf5uw=nmwSR=aHrVAW+vhXT7DBcphO+o49rH3wYk5G-W4mP8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Jun 2025 10:28:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1624

On 6/8/25 12:19, Michael Nazzareno Trimarchi via lists.yoctoproject.org
wrote:
> Hi all
>
> Anyone can provide some feedback?

meta-java has seen better days. Its maintainer has made some clear
statements about it not so long ago:
https://lists.openembedded.org/g/openembedded-devel/message/114958 - as
far I know this hasn't changed much.

>
> On Thu, Jun 5, 2025 at 7:14 AM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
>> According to https://archive.apache.org/dist/
>>
>> The directories and files linked below are a historical archive of
>> software released by Apache Software Foundation projects.
>>
>> THEY MAY BE UNSUPPORTED AND UNSAFE TO USE
>> Current releases can be found on our download server.
>>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>>  recipes-core/ant/ant-native_1.8.1.bb                      | 2 +-
>>  recipes-core/bcel/bcel_5.2.bb                             | 2 +-
>>  recipes-core/jakarta-commons/commons-cli_1.1.bb           | 2 +-
>>  recipes-core/jakarta-commons/commons-codec_1.3.bb         | 2 +-
>>  recipes-core/jakarta-commons/commons-collections_2.1.1.bb | 2 +-
>>  recipes-core/jakarta-commons/commons-digester_1.8.bb      | 2 +-
>>  recipes-core/jakarta-commons/commons-discovery_0.4.bb     | 2 +-
>>  recipes-core/jakarta-commons/commons-el_1.0.bb            | 2 +-
>>  recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb  | 2 +-
>>  recipes-core/jakarta-commons/commons-httpclient_3.1.bb    | 2 +-
>>  recipes-core/jakarta-commons/commons-io_1.4.bb            | 2 +-
>>  recipes-core/jakarta-commons/commons-lang_2.4.bb          | 2 +-
>>  recipes-core/jakarta-commons/commons-logging_1.1.1.bb     | 2 +-
>>  recipes-core/jakarta-commons/commons-net_1.4.1.bb         | 2 +-
>>  recipes-core/jakarta-commons/commons-pool_1.4.bb          | 2 +-
>>  recipes-core/jakarta-libs/avalon-framework-api_4.3.bb     | 4 ++--
>>  recipes-core/jakarta-libs/log4j1.2_1.2.17.bb              | 2 +-
>>  recipes-core/jakarta-libs/logkit_1.2.2.bb                 | 2 +-
>>  recipes-core/jakarta-libs/oro_2.0.8.bb                    | 2 +-
>>  recipes-core/jakarta-libs/poi_3.0.bb                      | 2 +-
>>  recipes-core/jakarta-libs/regexp_1.5.bb                   | 2 +-
>>  recipes-core/servlet-api/jsp2.0_5.5.26.bb                 | 2 +-
>>  recipes-core/servlet-api/servlet2.3_4.1.37.bb             | 2 +-
>>  recipes-core/servlet-api/servlet2.4_5.5.26.bb             | 2 +-
>>  recipes-core/xalan-j/xalan-j_2.7.1.bb                     | 2 +-
>>  recipes-core/xerces-j/xerces-j_2.11.0.bb                  | 2 +-
>>  recipes-core/xml-commons/dom4j_1.6.1.bb                   | 2 +-
>>  recipes-core/xml-commons/jaxp1.3_1.4.01.bb                | 2 +-
>>  recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb   | 2 +-
>>  29 files changed, 30 insertions(+), 30 deletions(-)
>>
>> diff --git a/recipes-core/ant/ant-native_1.8.1.bb b/recipes-core/ant/ant-native_1.8.1.bb
>> index b81f71d..75bfbdf 100644
>> --- a/recipes-core/ant/ant-native_1.8.1.bb
>> +++ b/recipes-core/ant/ant-native_1.8.1.bb
>> @@ -5,7 +5,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=503bb72c4dd62dd216d6820d5b869442"
>>  PR = "r1"
>>
>> -SRC_URI = "http://archive.apache.org/dist/ant/source/apache-ant-${PV}-src.tar.gz \
>> +SRC_URI = "https://downloads.apache.org/ant/source/apache-ant-${PV}-src.tar.gz \
>>            file://ant \
>>           "
>>
>> diff --git a/recipes-core/bcel/bcel_5.2.bb b/recipes-core/bcel/bcel_5.2.bb
>> index 7a8f46f..a525add 100644
>> --- a/recipes-core/bcel/bcel_5.2.bb
>> +++ b/recipes-core/bcel/bcel_5.2.bb
>> @@ -3,7 +3,7 @@ AUTHOR = "Apache Software Foundation"
>>  LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=44030f19e8bad73725f39d16fd05ff12"
>>  PR = "r1"
>> -SRC_URI = "http://archive.apache.org/dist/jakarta/bcel/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/jakarta/bcel/source/${BP}-src.tar.gz"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/jakarta-commons/commons-cli_1.1.bb b/recipes-core/jakarta-commons/commons-cli_1.1.bb
>> index 2b83a03..3e73cab 100644
>> --- a/recipes-core/jakarta-commons/commons-cli_1.1.bb
>> +++ b/recipes-core/jakarta-commons/commons-cli_1.1.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  SUMMARY = "Java argument parsing helper classes"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/cli/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/cli/source/${BP}-src.tar.gz"
>>
>>  SRC_URI[sha256sum] = "929eb140c136673e7f5029cd206c81b3c1f5e66bba0dfdcd021b9dd5596356d2"
>>
>> diff --git a/recipes-core/jakarta-commons/commons-codec_1.3.bb b/recipes-core/jakarta-commons/commons-codec_1.3.bb
>> index cfaada5..e638d54 100644
>> --- a/recipes-core/jakarta-commons/commons-codec_1.3.bb
>> +++ b/recipes-core/jakarta-commons/commons-codec_1.3.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  DESCRIPTION = "Java library with simple encoder and decoders for various formats such as Base64 and Hexadecimal"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/codec/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/codec/source/${BP}-src.tar.gz"
>>
>>  S = "${WORKDIR}/${BP}"
>>
>> diff --git a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
>> index 898a7df..566835d 100644
>> --- a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
>> +++ b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
>> @@ -4,7 +4,7 @@ PR = "${INC_PR}.1"
>>
>>  DESCRIPTION = "A set of abstract data type interfaces and implementations that offer a wealth of useful functionality and a solid foundation for extending that functionality"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/collections/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/collections/source/${BP}-src.tar.gz"
>>
>>
>>  SRC_URI[sha256sum] = "73eb5907a31c8770480c70f6a6a8d9a9a2ffe602e1b461c045cff51ace4cab2a"
>> diff --git a/recipes-core/jakarta-commons/commons-digester_1.8.bb b/recipes-core/jakarta-commons/commons-digester_1.8.bb
>> index 7e595ee..9c80860 100644
>> --- a/recipes-core/jakarta-commons/commons-digester_1.8.bb
>> +++ b/recipes-core/jakarta-commons/commons-digester_1.8.bb
>> @@ -4,7 +4,7 @@ PR = "${INC_PR}.1"
>>
>>  SUMMARY = "Converts XML to a Java object by a set of mapping rules."
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/digester/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/digester/source/${BP}-src.tar.gz"
>>
>>  DEPENDS += "commons-logging commons-beanutils"
>>  RDEPENDS:${PN} = "libcommons-logging-java libcommons-beanutils-java"
>> diff --git a/recipes-core/jakarta-commons/commons-discovery_0.4.bb b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
>> index 60cf683..8a64bb9 100644
>> --- a/recipes-core/jakarta-commons/commons-discovery_0.4.bb
>> +++ b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  SUMMARY = "discovering, or finding, implementations for pluggable interfaces"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/discovery/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/discovery/source/${BP}-src.tar.gz"
>>
>>  DEPENDS += "commons-logging"
>>  RDEPENDS:${PN} = "libcommons-logging-java"
>> diff --git a/recipes-core/jakarta-commons/commons-el_1.0.bb b/recipes-core/jakarta-commons/commons-el_1.0.bb
>> index b93b68f..94ca635 100644
>> --- a/recipes-core/jakarta-commons/commons-el_1.0.bb
>> +++ b/recipes-core/jakarta-commons/commons-el_1.0.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  SUMMARY = "Implementation of the JSP2.0 Expression Language API"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/el/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/el/source/${BP}-src.tar.gz"
>>
>>  DEPENDS += "jsp2.0 servlet2.4"
>>  RDEPENDS:${PN} = "libjsp2.0-java libservlet2.4-java"
>> diff --git a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
>> index 71a866b..36d2dde 100644
>> --- a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
>> +++ b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  DESCRIPTION = "Robust, high-performance, file upload capability for Java servlets and web applications"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/fileupload/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/fileupload/source/${BP}-src.tar.gz"
>>
>>  DEPENDS += "commons-beanutils commons-io servlet2.3"
>>  RDEPENDS:${PN} = "libcommons-beanutils-java libcommons-io-java libservlet2.3-java"
>> diff --git a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
>> index b4e5e2a..89a2fce 100644
>> --- a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
>> +++ b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  DESCRIPTION = "Efficient, up-to-date, and feature-rich package implementing the client side of the most recent HTTP standards and recommendations"
>>
>> -SRC_URI = "http://archive.apache.org/dist/httpcomponents/commons-httpclient/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/httpcomponents/commons-httpclient/source/${BP}-src.tar.gz"
>>
>>  S = "${WORKDIR}/${BP}"
>>
>> diff --git a/recipes-core/jakarta-commons/commons-io_1.4.bb b/recipes-core/jakarta-commons/commons-io_1.4.bb
>> index 799a9d4..bc92a24 100644
>> --- a/recipes-core/jakarta-commons/commons-io_1.4.bb
>> +++ b/recipes-core/jakarta-commons/commons-io_1.4.bb
>> @@ -5,6 +5,6 @@ PR = "${INC_PR}.1"
>>
>>  DESCRIPTION = "Java library with utility classes, stream implementations, file filters and endian classes"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/io/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/io/source/${BP}-src.tar.gz"
>>
>>  SRC_URI[sha256sum] = "eca986497f7b4d1b1ec41821b1b5df827bb31fc14833e4449cfa8bcd5d7f29bb"
>> diff --git a/recipes-core/jakarta-commons/commons-lang_2.4.bb b/recipes-core/jakarta-commons/commons-lang_2.4.bb
>> index e0c3736..bbb10e9 100644
>> --- a/recipes-core/jakarta-commons/commons-lang_2.4.bb
>> +++ b/recipes-core/jakarta-commons/commons-lang_2.4.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>
>>  DESCRIPTION = "Set of Java classes that provide helper methods for the standard java.lang classes"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/lang/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/lang/source/${BP}-src.tar.gz"
>>
>>
>>  SRC_URI[sha256sum] = "2445238cd0eb167e99a1147394f61325490559f3df7e7e8f628043fb70cbf2f4"
>> diff --git a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
>> index 6de3228..7045e9e 100644
>> --- a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
>> +++ b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
>> @@ -4,7 +4,7 @@ PR = "${INC_PR}.1"
>>
>>  SUMMARY = "Java Internet protocol suite library"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/logging/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/logging/source/${BP}-src.tar.gz"
>>
>>  DEPENDS += "log4j1.2 servlet2.3 logkit"
>>
>> diff --git a/recipes-core/jakarta-commons/commons-net_1.4.1.bb b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
>> index bffbbae..a62d55b 100644
>> --- a/recipes-core/jakarta-commons/commons-net_1.4.1.bb
>> +++ b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
>> @@ -5,7 +5,7 @@ PR = "${INC_PR}.1"
>>  SUMMARY = "Java Internet protocol suite library"
>>  LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/net/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/net/source/${BP}-src.tar.gz"
>>
>>  S = "${WORKDIR}/${BP}"
>>
>> diff --git a/recipes-core/jakarta-commons/commons-pool_1.4.bb b/recipes-core/jakarta-commons/commons-pool_1.4.bb
>> index 824b772..9ca7171 100644
>> --- a/recipes-core/jakarta-commons/commons-pool_1.4.bb
>> +++ b/recipes-core/jakarta-commons/commons-pool_1.4.bb
>> @@ -5,6 +5,6 @@ PR = "${INC_PR}.1"
>>
>>  SUMMARY = "Java Object-pooling API"
>>
>> -SRC_URI = "http://archive.apache.org/dist/commons/pool/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/commons/pool/source/${BP}-src.tar.gz"
>>
>>  SRC_URI[sha256sum] = "ca4452f2a2ce2daf6eaa1743ded2d3b36013200c48e3f2117b65584ca5cc1d9b"
>> diff --git a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
>> index 081cfe7..d2bf3d7 100644
>> --- a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
>> +++ b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
>> @@ -5,8 +5,8 @@ LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=1dece7821bf3fd70fe1309eaa37d52a2"
>>  PR = "r1"
>>
>>  SRC_URI = " \
>> -          http://archive.apache.org/dist/excalibur/avalon-framework/source/${BP}-src.tar.gz;name=archive \
>> -          http://archive.apache.org/dist/avalon/logkit/source/logkit-1.2.2-src.tar.gz;name=logkit \
>> +          https://downloads.apache.org/excalibur/avalon-framework/source/${BP}-src.tar.gz;name=archive \
>> +          https://downloads.apache.org/avalon/logkit/source/logkit-1.2.2-src.tar.gz;name=logkit \
>>           "
>>
>>  inherit java-library
>> diff --git a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
>> index bd8c9d8..9f52671 100644
>> --- a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
>> +++ b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
>> @@ -5,7 +5,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=f4ce41a6d1028498fcacde12f589bce7"
>>
>>  PR = "r2"
>>
>> -SRC_URI = "http://archive.apache.org/dist/logging/log4j/${PV}/log4j-${PV}.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/logging/log4j/${PV}/log4j-${PV}.tar.gz"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/jakarta-libs/logkit_1.2.2.bb b/recipes-core/jakarta-libs/logkit_1.2.2.bb
>> index c3d83a5..154d982 100644
>> --- a/recipes-core/jakarta-libs/logkit_1.2.2.bb
>> +++ b/recipes-core/jakarta-libs/logkit_1.2.2.bb
>> @@ -4,7 +4,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=f1a1c8e1996e51c4dbc73e592a2ecf05"
>>  PR = "r1"
>>
>> -SRC_URI = "http://archive.apache.org/dist/avalon/logkit/source/${BP}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/avalon/logkit/source/${BP}-src.tar.gz"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/jakarta-libs/oro_2.0.8.bb b/recipes-core/jakarta-libs/oro_2.0.8.bb
>> index 80efd49..8e3a249 100644
>> --- a/recipes-core/jakarta-libs/oro_2.0.8.bb
>> +++ b/recipes-core/jakarta-libs/oro_2.0.8.bb
>> @@ -4,7 +4,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=372b1e91335021ca74173b2ab4dc97dd"
>>  PR = "r1"
>>
>> -SRC_URI = "http://archive.apache.org/dist/jakarta/oro/source/jakarta-${BP}.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/jakarta/oro/source/jakarta-${BP}.tar.gz"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/jakarta-libs/poi_3.0.bb b/recipes-core/jakarta-libs/poi_3.0.bb
>> index 3733c3c..f67314b 100644
>> --- a/recipes-core/jakarta-libs/poi_3.0.bb
>> +++ b/recipes-core/jakarta-libs/poi_3.0.bb
>> @@ -3,7 +3,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
>>  AUTHOR = "Apache Software Foundation"
>>
>> -SRC_URI = "http://archive.apache.org/dist/jakarta/poi/release/src/${BPN}-src-${PV}-FINAL-20070503.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/jakarta/poi/release/src/${BPN}-src-${PV}-FINAL-20070503.tar.gz"
>>
>>  S = "${WORKDIR}/${BPN}-3.0-rc4"
>>
>> diff --git a/recipes-core/jakarta-libs/regexp_1.5.bb b/recipes-core/jakarta-libs/regexp_1.5.bb
>> index 40dec0a..60635b4 100644
>> --- a/recipes-core/jakarta-libs/regexp_1.5.bb
>> +++ b/recipes-core/jakarta-libs/regexp_1.5.bb
>> @@ -4,7 +4,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"
>>  PR = "r1"
>>
>> -SRC_URI = "http://archive.apache.org/dist/jakarta/regexp/source/jakarta-${BP}.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/jakarta/regexp/source/jakarta-${BP}.tar.gz"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/servlet-api/jsp2.0_5.5.26.bb b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
>> index 3d9f4da..5f84249 100644
>> --- a/recipes-core/servlet-api/jsp2.0_5.5.26.bb
>> +++ b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
>> @@ -3,7 +3,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
>>  AUTHOR = "Apache Software Foundation"
>>
>> -SRC_URI = "http://archive.apache.org/dist/tomcat/tomcat-5/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/tomcat/tomcat-5/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
>>
>>  S = "${WORKDIR}/apache-tomcat-${PV}-src/servletapi/jsr152"
>>
>> diff --git a/recipes-core/servlet-api/servlet2.3_4.1.37.bb b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
>> index dceece6..0bf8552 100644
>> --- a/recipes-core/servlet-api/servlet2.3_4.1.37.bb
>> +++ b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
>> @@ -4,7 +4,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
>>  PR = "r1"
>>
>> -SRC_URI = "http://archive.apache.org/dist/tomcat/tomcat-4/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/tomcat/tomcat-4/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/servlet-api/servlet2.4_5.5.26.bb b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
>> index eb2f769..1cc8d6e 100644
>> --- a/recipes-core/servlet-api/servlet2.4_5.5.26.bb
>> +++ b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
>> @@ -3,7 +3,7 @@ LICENSE = "Apache-2.0"
>>  LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
>>  AUTHOR = "Apache Software Foundation"
>>
>> -SRC_URI = "http://archive.apache.org/dist/tomcat/tomcat-5/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/tomcat/tomcat-5/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
>>
>>  S = "${WORKDIR}/apache-tomcat-${PV}-src/servletapi/jsr154"
>>
>> diff --git a/recipes-core/xalan-j/xalan-j_2.7.1.bb b/recipes-core/xalan-j/xalan-j_2.7.1.bb
>> index 5e72a34..b697da2 100644
>> --- a/recipes-core/xalan-j/xalan-j_2.7.1.bb
>> +++ b/recipes-core/xalan-j/xalan-j_2.7.1.bb
>> @@ -12,7 +12,7 @@ PR = "r2"
>>  DEPENDS = "xerces-j regexp jlex cup jaxp1.3 bcel"
>>
>>  SRC_URI = "\
>> -       http://archive.apache.org/dist/xml/${BPN}/${BPN}_2_7_1-src.tar.gz;name=archive \
>> +       https://downloads.apache.org/xml/${BPN}/${BPN}_2_7_1-src.tar.gz;name=archive \
>>         https://dlcdn.apache.org/commons/bsf/source/bsf-src-2.4.0.tar.gz;name=bsf \
>>         "
>>
>> diff --git a/recipes-core/xerces-j/xerces-j_2.11.0.bb b/recipes-core/xerces-j/xerces-j_2.11.0.bb
>> index 56ffe97..3b2a64d 100644
>> --- a/recipes-core/xerces-j/xerces-j_2.11.0.bb
>> +++ b/recipes-core/xerces-j/xerces-j_2.11.0.bb
>> @@ -12,7 +12,7 @@ LIC_FILES_CHKSUM = " \
>>                      file://LICENSE.serializer.txt;md5=d229da563da18fe5d58cd95a6467d584 \
>>                     "
>>
>> -SRC_URI = "http://archive.apache.org/dist/xerces/j/source/Xerces-J-src.${PV}.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/xerces/j/source/Xerces-J-src.${PV}.tar.gz"
>>
>>  # CVE only applies to some Oracle Java SE and Red Hat Enterprise Linux versions.
>>  # Already fixed with updates and closed.
>> diff --git a/recipes-core/xml-commons/dom4j_1.6.1.bb b/recipes-core/xml-commons/dom4j_1.6.1.bb
>> index 0ba3f0e..ac8d02e 100644
>> --- a/recipes-core/xml-commons/dom4j_1.6.1.bb
>> +++ b/recipes-core/xml-commons/dom4j_1.6.1.bb
>> @@ -10,7 +10,7 @@ DEPENDS = "fastjar-native virtual/javac-native \
>>
>>  SRC_URI = "\
>>          ${SOURCEFORGE_MIRROR}/dom4j/${P}.tar.gz;name=archive \
>> -        http://archive.apache.org/dist/ws/jaxme/source/ws-jaxme-0.5.2-src.tar.gz;name=jaxme \
>> +        https://downloads.apache.org/ws/jaxme/source/ws-jaxme-0.5.2-src.tar.gz;name=jaxme \
>>          file://debian.patch \
>>  "
>>  SRC_URI[archive.md5sum] = "1e7ef6d20939315714de4a8502f27b2d"
>> diff --git a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
>> index 7965bb8..558f2c2 100644
>> --- a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
>> +++ b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
>> @@ -9,7 +9,7 @@ LIC_FILES_CHKSUM = " \
>>                      file://LICENSE.sax.txt;md5=3534555610af53d4b5a8a0d2fb017d35 \
>>                     "
>>
>> -SRC_URI = "http://archive.apache.org/dist/xml/commons/source/xml-commons-external-${PV}-src.tar.gz;subdir=${BPN}-${PV}"
>> +SRC_URI = "https://downloads.apache.org/xml/commons/source/xml-commons-external-${PV}-src.tar.gz;subdir=${BPN}-${PV}"
>>
>>  inherit java-library
>>
>> diff --git a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
>> index 0fafcea..0174aeb 100644
>> --- a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
>> +++ b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
>> @@ -4,7 +4,7 @@ LICENSE = "Apache-2.0"
>>  PR = "r1"
>>  LIC_FILES_CHKSUM = "file://LICENSE.resolver.txt;md5=d229da563da18fe5d58cd95a6467d584"
>>
>> -SRC_URI = "http://archive.apache.org/dist/xml/commons/xml-commons-resolver-${PV}.tar.gz"
>> +SRC_URI = "https://downloads.apache.org/xerces/xml-commons/xml-commons-resolver-${PV}.tar.gz"
>>
>>  inherit java-library
>>
>> --
>> 2.43.0
>>
>


