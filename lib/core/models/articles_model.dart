class ArticlesModel {
    ArticlesModel({
        required this.status,
        required this.copyright,
        required this.response,
    });

    final String? status;
    final String? copyright;
    final Response? response;

    factory ArticlesModel.fromJson(Map<String, dynamic> json){ 
        return ArticlesModel(
            status: json["status"]??"",
            copyright: json["copyright"]??"",
            response: json["response"] == null ? null : Response.fromJson(json["response"]),
        );
    }

}

class Response {
    Response({
        required this.docs,
        //required this.meta,
    });

    final List<Doc> docs;
    //final Meta? meta;

    factory Response.fromJson(Map<String, dynamic> json){ 
        return Response(
            docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
            //meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }
}

class Doc {
    Doc({
        required this.docAbstract,
        required this.webUrl,
        required this.snippet,
        required this.leadParagraph,
        required this.source,
        required this.multimedia,
        required this.headline,
        required this.byline,
    });

    final String? docAbstract;
    final String? webUrl;
    final String? snippet;
    final String? leadParagraph;
    final String? source;
    final List<Multimedia> multimedia;
    final Headline? headline;
    final Byline? byline;

    factory Doc.fromJson(Map<String, dynamic> json){ 
        return Doc(
            docAbstract: json["abstract"]??"",
            webUrl: json["web_url"]??"",
            snippet: json["snippet"]??"",
            leadParagraph: json["lead_paragraph"]??"",
            source: json["source"]??"",
            multimedia: json["multimedia"] == null ? [] : List<Multimedia>.from(json["multimedia"]!.map((x) => Multimedia.fromJson(x))),
            headline: json["headline"] == null ? null : Headline.fromJson(json["headline"]),
            byline: json["byline"] == null ? null : Byline.fromJson(json["byline"]),
        );
    }
}

class Byline {
    Byline({
        required this.original,
    });

    final String? original;

    factory Byline.fromJson(Map<String, dynamic> json){ 
        return Byline(
            original: json["original"],
        );
    }
}

class Person {
    Person({
        required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.qualifier,
        required this.title,
        required this.role,
        required this.organization,
        required this.rank,
    });

    final String? firstname;
    final String? middlename;
    final String? lastname;
    final dynamic qualifier;
    final dynamic title;
    final String? role;
    final String? organization;
    final int? rank;

    factory Person.fromJson(Map<String, dynamic> json){ 
        return Person(
            firstname: json["firstname"]??"",
            middlename: json["middlename"]??"",
            lastname: json["lastname"]??"",
            qualifier: json["qualifier"],
            title: json["title"],
            role: json["role"]??"",
            organization: json["organization"]??"",
            rank: json["rank"],
        );
    }

}

class Headline {
    Headline({
        required this.main,
        required this.kicker,
        required this.contentKicker,
        required this.printHeadline,
        required this.name,
        required this.seo,
        required this.sub,
    });

    final String? main;
    final dynamic kicker;
    final dynamic contentKicker;
    final String? printHeadline;
    final dynamic name;
    final dynamic seo;
    final dynamic sub;

    factory Headline.fromJson(Map<String, dynamic> json){ 
        return Headline(
            main: json["main"]??"",
            kicker: json["kicker"],
            contentKicker: json["content_kicker"],
            printHeadline: json["print_headline"]??"",
            name: json["name"],
            seo: json["seo"],
            sub: json["sub"],
        );
    }

}

class Keyword {
    Keyword({
        required this.name,
        required this.value,
        required this.rank,
        required this.major,
    });

    final String? name;
    final String? value;
    final int? rank;
    final String? major;

    factory Keyword.fromJson(Map<String, dynamic> json){ 
        return Keyword(
            name: json["name"]??"",
            value: json["value"]??"",
            rank: json["rank"],
            major: json["major"]??"",
        );
    }

}

class Multimedia {
    Multimedia({
        required this.rank,
        required this.subtype,
        required this.caption,
        required this.credit,
        required this.type,
        required this.url,
        required this.height,
        required this.width,
        required this.legacy,
        required this.subType,
        required this.cropName,
    });

    final int? rank;
    final String? subtype;
    final dynamic caption;
    final dynamic credit;
    final String? type;
    final String? url;
    final int? height;
    final int? width;
    final Legacy? legacy;
    final String? subType;
    final String? cropName;

    factory Multimedia.fromJson(Map<String, dynamic> json){ 
        return Multimedia(
            rank: json["rank"],
            subtype: json["subtype"]??"",
            caption: json["caption"],
            credit: json["credit"],
            type: json["type"]??"",
            url: json["url"]??"",
            height: json["height"],
            width: json["width"],
            legacy: json["legacy"] == null ? null : Legacy.fromJson(json["legacy"]),
            subType: json["subType"]??"",
            cropName: json["crop_name"]??"",
        );
    }

}

class Legacy {
    Legacy({
        required this.xlarge,
        required this.xlargewidth,
        required this.xlargeheight,
        required this.thumbnail,
        required this.thumbnailwidth,
        required this.thumbnailheight,
        required this.widewidth,
        required this.wideheight,
        required this.wide,
    });

    final String? xlarge;
    final int? xlargewidth;
    final int? xlargeheight;
    final String thumbnail;
    final int? thumbnailwidth;
    final int? thumbnailheight;
    final int? widewidth;
    final int? wideheight;
    final String? wide;

    factory Legacy.fromJson(Map<String, dynamic> json){ 
        return Legacy(
            xlarge: json["xlarge"]??"",
            xlargewidth: json["xlargewidth"],
            xlargeheight: json["xlargeheight"],
            thumbnail: json["thumbnail"]??"",
            thumbnailwidth: json["thumbnailwidth"],
            thumbnailheight: json["thumbnailheight"],
            widewidth: json["widewidth"],
            wideheight: json["wideheight"],
            wide: json["wide"]??"",
        );
    }

}

class Meta {
    Meta({
        required this.hits,
        required this.offset,
        required this.time,
    });

    final int hits;
    final int offset;
    final int time;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            hits: json["hits"],
            offset: json["offset"],
            time: json["time"],
        );
    }

}
