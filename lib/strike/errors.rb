module Strike
  class Errors
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    NOT_FOUND = 404
    TOO_MANY_REQUESTS = 429
    INTERNAL_SERVER_ERROR = 500

    class BadRequestError < StandardError
      def initialize(msg = 'The request has not been accepted. Check your parameters.')
        super
      end
    end

    class UnauthorizedError < StandardError
      def initialize(msg = 'Invalid API Key.')
        super
      end
    end

    class NotFoundError < StandardError
      def initialize(msg = 'The resource does not exist.')
        super
      end
    end

    class TooManyRequestsError < StandardError
      def initialize(msg = 'You have exceeded your request limit.')
        super
      end
    end

    class InternalServerError < StandardError
      def initialize(msg = 'There was an internal API error.')
        super
      end
    end

    ERROR_MAP = {
      BAD_REQUEST => BadRequestError,
      UNAUTHORIZED => UnauthorizedError,
      NOT_FOUND => NotFoundError,
      TOO_MANY_REQUESTS => TooManyRequestsError,
      INTERNAL_SERVER_ERROR => InternalServerError
    }.freeze
  end
end
