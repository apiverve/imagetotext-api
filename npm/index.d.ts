declare module '@apiverve/imagetotext' {
  export interface imagetotextOptions {
    api_key: string;
    secure?: boolean;
  }

  export interface imagetotextResponse {
    status: string;
    error: string | null;
    data: ImagetoTextData;
    code?: number;
  }


  interface ImagetoTextData {
      text:       string;
      confidence: number;
      words:      number;
      characters: number;
      lines:      number;
  }

  export default class imagetotextWrapper {
    constructor(options: imagetotextOptions);

    execute(callback: (error: any, data: imagetotextResponse | null) => void): Promise<imagetotextResponse>;
    execute(query: Record<string, any>, callback: (error: any, data: imagetotextResponse | null) => void): Promise<imagetotextResponse>;
    execute(query?: Record<string, any>): Promise<imagetotextResponse>;
  }
}
